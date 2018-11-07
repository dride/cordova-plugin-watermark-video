#import <Cordova/CDV.h>

@interface Watermark : CDVPlugin


// Main functions
- (void)addWatermarkToVideo:(CDVInvokedUrlCommand *)command;
- (void)updateExportDisplay:(NSTimer*)progress;



@end
