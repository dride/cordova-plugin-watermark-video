const plugin = function() {
  return (<any>window).watermarkVideo;
};

export default class WatermarkVideo {
  static addWatermarkToVideo(
    videoSrc: string,
    videoDest: string,
    waterMarkImageSrc: string,
    top: number,
    left: number
  ) {
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
