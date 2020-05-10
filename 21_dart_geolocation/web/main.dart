import 'dart:html';

final arrow = document.querySelector('.arrow');
final speed = document.querySelector('.speed-value') as SpanElement;

void main() {
  final watch = window.navigator.geolocation.watchPosition();
  watch.listen((Geoposition data) {
    print(data.coords.speed);
    speed.text = '${data.coords.speed}';
    arrow.style.transform = 'rotate(${data.coords.heading}deg)';
  });
}
