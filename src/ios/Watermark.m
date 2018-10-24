#import "Watermark.h"
#import <AVFoundation/AVFoundation.h>


@implementation Watermark

- (void)addWatermarkToVideo:(CDVInvokedUrlCommand*)command {
   

    NSDictionary* options = [command argumentAtIndex:0];
    NSString* videoSrc = [options objectForKey:@"videoSrc"];
    NSString* videoDest = [options objectForKey:@"videoDest"];
    NSString* waterMarkImageSrc = [options objectForKey:@"waterMarkImageSrc"];
    CGFloat top = [[options objectForKey:@"top"] doubleValue];
    CGFloat left = [[options objectForKey:@"left"] doubleValue];

    
    NSString *filePath = videoSrc;
    
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:filePath]  options:nil];
    
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack *clipVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    AVMutableCompositionTrack *compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack *clipAudioTrack = [[videoAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) ofTrack:clipVideoTrack atTime:kCMTimeZero error:nil];
    [compositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) ofTrack:clipAudioTrack atTime:kCMTimeZero error:nil];
    
    [compositionVideoTrack setPreferredTransform:[[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] preferredTransform]];
    
    CGSize videoSize = [clipVideoTrack naturalSize];
    
    
    NSURL *localurl = [NSURL URLWithString:waterMarkImageSrc];
    NSData *data = [NSData dataWithContentsOfURL:localurl];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    CALayer *aLayer = [CALayer layer];
    aLayer.contents = (id)image.CGImage;
    aLayer.frame = CGRectMake(top, (videoSize.height - image.size.height) + left, image.size.width, image.size.height);
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    videoLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:aLayer];
    
    
    AVMutableVideoComposition* videoComp = [AVMutableVideoComposition videoComposition];
    videoComp.renderSize = videoSize;
    videoComp.frameDuration = CMTimeMake(1, 30);
    videoComp.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    
    AVMutableVideoCompositionInstruction *instruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    instruction.timeRange = CMTimeRangeMake(kCMTimeZero, [mixComposition duration]);
    AVAssetTrack *videoTrack = [[mixComposition tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    AVMutableVideoCompositionLayerInstruction* layerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    instruction.layerInstructions = [NSArray arrayWithObject:layerInstruction];
    videoComp.instructions = [NSArray arrayWithObject: instruction];
    
    AVAssetExportSession *assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];//AVAssetExportPresetPassthrough
    assetExport.videoComposition = videoComp;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* VideoName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, videoDest];
    
    NSURL *exportUrl = [NSURL fileURLWithPath:VideoName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:VideoName])
    {
        [[NSFileManager defaultManager] removeItemAtPath:VideoName error:nil];
    }
    
    assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    assetExport.outputURL = exportUrl;
    assetExport.shouldOptimizeForNetworkUse = YES;
    

    [assetExport exportAsynchronouslyWithCompletionHandler:
     ^(void ) {
         dispatch_async(dispatch_get_main_queue(), ^{
             CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%@", assetExport.outputURL]];
             [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
         });
     }
     ];

}





@end
