const plugin = function() {
  return (<any>window).watermarkVideo;
};

export default class watermarkVideo {
  static addWatermarkToVideo() {
    let watermark = plugin();
    watermark.addWatermarkToVideo.apply(watermark, arguments);
  }
}
