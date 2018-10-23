#import "Watermark.h"

@implementation Watermark

- (void)addWatermarkToVideo:(CDVInvokedUrlCommand*)command {
    CDVPluginResult *pluginResult = nil;

	//add watermark to video
	//addAnimation()

	//copy video to dest




    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Not supported"];

    [self.commandDelegate sendPluginResult:pluginResult
                                callbackId:command.callbackId];
}


- (void)addAnimation
{       
    NSString *filePath = [[NSBundle mainBundle] pathForResource:videoName ofType:ext];

    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:filePath]  options:nil];

    AVMutableComposition* mixComposition = [AVMutableComposition composition];

    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];

    AVAssetTrack *clipVideoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];

    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) ofTrack:clipVideoTrack atTime:kCMTimeZero error:nil];

    [compositionVideoTrack setPreferredTransform:[[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] preferredTransform]];

    CGSize videoSize = [clipVideoTrack naturalSize];

    UIImage *myImage = [UIImage imageNamed:@"29.png"];
    CALayer *aLayer = [CALayer layer];
    aLayer.contents = (id)myImage.CGImage;
    aLayer.frame = CGRectMake(videoSize.width - 65, videoSize.height - 75, 57, 57);
    aLayer.opacity = 0.65;
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    videoLayer.frame = CGRectMake(0, 0, videoSize.width, videoSize.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:aLayer];

    CATextLayer *titleLayer = [CATextLayer layer];
    titleLayer.string = @"Text goes here";
    titleLayer.font = CFBridgingRetain(@"Helvetica");
    titleLayer.fontSize = videoSize.height / 6;
    //?? titleLayer.shadowOpacity = 0.5;
    titleLayer.alignmentMode = kCAAlignmentCenter;
    titleLayer.bounds = CGRectMake(0, 0, videoSize.width, videoSize.height / 6); //You may need to adjust this for proper display
    [parentLayer addSublayer:titleLayer]; //ONLY IF WE ADDED TEXT

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
    NSString* VideoName = [NSString stringWithFormat:@"%@/mynewwatermarkedvideo.mp4",documentsDirectory];


    //NSString *exportPath = [NSTemporaryDirectory() stringByAppendingPathComponent:VideoName];
    NSURL *exportUrl = [NSURL fileURLWithPath:VideoName];

    if ([[NSFileManager defaultManager] fileExistsAtPath:VideoName])
    {
        [[NSFileManager defaultManager] removeItemAtPath:VideoName error:nil];
    }

    assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    assetExport.outputURL = exportUrl;
    assetExport.shouldOptimizeForNetworkUse = YES;

    //[strRecordedFilename setString: exportPath];

    [assetExport exportAsynchronouslyWithCompletionHandler:
     ^(void ) {
         dispatch_async(dispatch_get_main_queue(), ^{
             [self exportDidFinish:assetExport];
         });
     }
     ];
}

-(void)exportDidFinish:(AVAssetExportSession*)session
{
    NSURL *exportUrl = session.outputURL;
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:exportUrl])
    {
        [library writeVideoAtPathToSavedPhotosAlbum:exportUrl completionBlock:^(NSURL *assetURL, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (error) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [alert show];
                 } else {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                                    delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [alert show];
                 }
             });
         }];

    }
    NSLog(@"Completed");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AlertView" message:@"Video is edited successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


@end
