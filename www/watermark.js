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

var Watermark = {
  addWatermarkToVideo: function(
    videoSrc,
    videoDest,
    waterMarkImageSrc,
    top,
    left,
    progress
  ) {
    return new Promise(function(resolve, reject) {
      var callback = function(result) {
        try {
          var res = JSON.parse(result);
          if (res.progress) {
            if (progress) {
              progress(res.progress);
            }
          }
          if (res.done) {
            resolve(res.outputUrl);
          }
        } catch (e) {
          console.error(e);
          reject(e);
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
  }
};

module.exports = Watermark;
