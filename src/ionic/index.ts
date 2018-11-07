const plugin = function() {
  return (<any>window).Watermark;
};

export default class WatermarkVideo {
  /**
   * @description Add water mark to a video
   *
   * @returns Promise: dest path of video
   * @param videoSrc src of video, should be a url, use ionic's convertFileSrc method to access the local server
   * @param videoDest name of destination video, will generate this video in 'documentsDirectory'
   * @param waterMarkImageSrc src of water mark image, use example to see how to add local images
   * @param top position of image - 0 for top
   * @param left position of image - 0 for left
   * @param progress return the progress status in %
   * @example
   * ```typescript
   * watermarkVideo.addWatermarkToVideo(
   * 		window.Ionic.WebView.convertFileSrc('file://...'),
   *		"tmp.mp4",
   *		window.Ionic.WebView.convertFileSrc(this.file.applicationDirectory + "www/assets/images/stripe.png"),
   *		0,
   *		0
   *);
   * ```
   */

  static addWatermarkToVideo(
    videoSrc: string,
    videoDest: string,
    waterMarkImageSrc: string,
    top: number,
    left: number,
    progress: () => string
  ): Promise<string> {
    let watermark = plugin();
    return watermark.addWatermarkToVideo.apply(watermark, [
      videoSrc,
      videoDest,
      waterMarkImageSrc,
      top,
      left
    ]);
  }
}
