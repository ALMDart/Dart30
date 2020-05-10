import 'dart:html';

void main() {
  final timeNodes = querySelectorAll('[data-time]');

  final seconds = timeNodes
      .map((node) => node.dataset['time'])
      .map((timeCode) {

        final split = timeCode.split(':').map(num.parse);
        final mins = split.first;
        final secs = split.last;
        return (mins * 60) + secs;
      })
      .reduce((total, vidSeconds) => total + vidSeconds);

  var secondsLeft = seconds;
  final hours = (secondsLeft / 3600).floor();
  secondsLeft = secondsLeft % 3600;

  final mins = (secondsLeft / 60).floor();
  secondsLeft = secondsLeft % 60;

  print('hr: ${hours}, mins: ${mins}, secs: ${secondsLeft}');
}
