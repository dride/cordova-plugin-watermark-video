[![npm version](https://badge.fury.io/js/cordova-plugin-watermark-video.svg)](https://badge.fury.io/js/cordova-plugin-watermark-video)

# PhoneGap/Cordova add watermark to video

## Installation

    cordova plugin add ccordova-plugin-watermark-video

## Supported Platforms

- Android
- iOS

## Usage

```
window.Watermark.addWatermarkToVideo(
	videoSrc,
	videoDest,
	waterMarkImageSrc,
	top,
	left,
	done => {},
	error => {}
);
```

## Response

done: string - videoDest URI
