/*
 * Copyright 2018 Myles McNamara
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

/**
 * Watermark add watermark to a video.
 * @constructor
 */
var Watermark = function() {
  this.onProgress = null; // optional callback
};

FileTransfer.prototype.addWatermarkToVideo = function(
  videoSrc,
  videoDest,
  waterMarkImageSrc,
  top,
  left,
  progress
) {
  return new Promise(function(resolve, reject) {
    var callback = function(result) {
      console.log(result);
      if (typeof result != "undefined") {
        if (progress) {
          progress(result);
        }
      } else {
        resolve(result);
      }
    };

    cordova.exec(callback, reject, "Watermark", "addWatermarkToVideo", [
      {
        videoSrc: videoSrc,
        videoDest: videoDest,
        waterMarkImageSrc: waterMarkImageSrc,
        top: top,
        left: left
      }
    ]);
  });
};

module.exports = Watermark;
