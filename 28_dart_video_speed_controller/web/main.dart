import 'dart:html';

final speed = document.querySelector('.speed');
final bar = speed.querySelector('.speed-bar');
final video = document.querySelector('.flex') as VideoElement;

void handleMove(Event e) {
  if(e is! MouseEvent) return;
  final mouseEvent = e as MouseEvent;
  final target = e.currentTarget as HtmlElement;
  final y = mouseEvent.page.y - target.offsetTop;
  final percent = y / target.offsetHeight;
  final min = 0.4;
  final max = 4;
  final height = '${(percent * 100).round()}%';
  final playbackRate = percent * (max - min) + min;
  bar.style.height = height;
  bar.text = playbackRate.toStringAsFixed(2) + '×';
  video.playbackRate = playbackRate;
}

void main() {
  speed.addEventListener('mousemove', handleMove);
}
