import 'dart:async';
import 'dart:html';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

final video = document.querySelector('.player') as VideoElement;
final canvas = document.querySelector('.photo') as CanvasElement;
final ctx = canvas.getContext('2d') as CanvasRenderingContext2D;
final strip = document.querySelector('.strip');
final snap = document.querySelector('.snap') as AudioElement;

void getVideo() {
  window.navigator
      .getUserMedia(video: true, audio: false)
      .then((localMediaStream) {
    print(localMediaStream);

//  DEPRECIATION :
//       The following has been depreceated by major browsers as of Chrome and Firefox.
//       video.src = window.URL.createObjectURL(localMediaStream);
//       Please refer to these:
//       Deprecated  - https://developer.mozilla.org/en-US/docs/Web/API/URL/createObjectURL
//       Newer Syntax - https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/srcObject

    video.srcObject = localMediaStream;
    video.play();
  }).catchError((err) => window.console.error('OH NO!!! ${err}'));
}

void paintToCanvas(Event e) {
  final width = video.videoWidth;
  final height = video.videoHeight;
  canvas.width = width;
  canvas.height = height;

  Timer(Duration(milliseconds: 16), () {
    ctx.drawImage(video, 0, 0);
    //  ctx.drawImage(video, 0, 0, width, height);
    // take the pixels out
    var pixels = ctx.getImageData(0, 0, width, height);
    // mess with them
    // pixels = redEffect(pixels);

    pixels = rgbSplit(pixels);
    // ctx.globalAlpha = 0.8;

    // pixels = greenScreen(pixels);
    // put them back
    ctx.putImageData(pixels, 0, 0);
  });
}

void takePhoto() {
  // played the sound
  snap.currentTime = 0;
  snap.play();

  // take the data out of the canvas
  final data = canvas.toDataUrl('image/jpeg');
  final link = document.createElement('a') as AnchorElement;
  link.href = data;
  link.setAttribute('download', 'handsome');
  final img = ImageElement();
  img.alt = 'Handsome Man';
  img.src = '${data}';
  link.append(img);
  strip.insertBefore(link, strip.firstChild);
}

ImageData redEffect(ImageData pixels) {
  for (var i = 0; i < pixels.data.length; i += 4) {
    pixels.data[i + 0] = pixels.data[i + 0] + 200; // RED
    pixels.data[i + 1] = pixels.data[i + 1] - 50; // GREEN
    pixels.data[i + 2] = (pixels.data[i + 2] * 0.5).round(); // Blue
  }
  return pixels;
}

ImageData rgbSplit(ImageData pixels) {
  for (var i = 0; i < pixels.data.length; i += 4) {
    var tmp = i - 150;
    if (tmp > 0 && tmp < pixels.data.lengthInBytes) pixels.data[tmp] = pixels.data[i + 0]; // RED
    tmp = i + 500;
    if (tmp > 0 && tmp < pixels.data.lengthInBytes) pixels.data[tmp] = pixels.data[i + 1]; // GREEN
    tmp = i - 550;
    if (tmp > 0 && tmp < pixels.data.lengthInBytes) pixels.data[tmp] = pixels.data[i + 2]; // Blue
  }
  return pixels;
}

ImageData greenScreen(ImageData pixels) {
  final levels = {};

  querySelectorAll('.rgb input').forEach((input) {
    final target = input as InputElement;
    levels[target.name] = target.value;
  });

  for (var i = 0; i < pixels.data.length; i = i + 4) {
    var red = pixels.data[i + 0];
    var green = pixels.data[i + 1];
    var blue = pixels.data[i + 2];
    var alpha = pixels.data[i + 3];

    if (red >= levels['rmin'] &&
        green >= levels['gmin'] &&
        blue >= levels['bmin'] &&
        red <= levels['rmax'] &&
        green <= levels['gmax'] &&
        blue <= levels['bmax']) {
      // take it out!
      pixels.data[i + 3] = 0;
    }
  }

  return pixels;
}

void main() {
  getVideo();
  video.addEventListener('canplay', paintToCanvas);
  setProperty(window, 'takePhoto', allowInterop(takePhoto));
}
