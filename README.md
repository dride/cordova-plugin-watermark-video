[![npm version](https://badge.fury.io/js/cordova-plugin-watermark-video.svg)](https://badge.fury.io/js/cordova-plugin-watermark-video)

# PhoneGap/Cordova add watermark to video

## Installation

    cordova plugin add ccordova-plugin-watermark-video

## Supported Platforms

- Android
- iOS

## Usage

### Typescript

```
import WatermarkVideo from "cordova-plugin-watermark-video";

WatermarkVideo.addWatermarkToVideo(
	videoSrc,
	videoDest,
	waterMarkImageSrc,
	top,
	left
);
```

### Javascript

```
window.Watermark.addWatermarkToVideo(
	videoSrc,
	videoDest,
	waterMarkImageSrc,
	top,
	left
);
```

## Response Promise<{videoDest: 'URI'}>

done: string - videoDest URI
