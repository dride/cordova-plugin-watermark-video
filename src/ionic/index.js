var plugin = function () {
    return window.watermarkVideo;
};
var watermarkVideo = (function () {
    function watermarkVideo() {
    }
    watermarkVideo.addWatermarkToVideo = function () {
        var watermark = plugin();
        watermark.addWatermarkToVideo.apply(watermark, arguments);
    };
    return watermarkVideo;
}());
export default watermarkVideo;
