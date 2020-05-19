# Dart30 - 25 Event Capture Propagation

After a week of investigation I believe it's currently impractical to implement this lesson because of it's use of once.

The current dart:html library does not support the once property on addEventListener, only capture.

I thoroughly investigated both the dart:js and packge:js packages to solve this but it doesn't not appear a clean solution is possible that resembles the original api.