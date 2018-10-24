var plugin = function () {
    return window.watermarkVideo;
};
var WatermarkVideo = (function () {
    function WatermarkVideo() {
    }
    WatermarkVideo.addWatermarkToVideo = function (videoSrc, videoDest, waterMarkImageSrc, top, left) {
        var watermark = plugin();
        return watermark.addWatermarkToVideo.apply(watermark, [
            videoSrc,
            videoDest,
            waterMarkImageSrc,
            top,
            left
        ]);
    };
    return WatermarkVideo;
}());
export default WatermarkVideo;
