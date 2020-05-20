import 'dart:async';
import 'dart:html';

var countdown;
final timerDisplay = querySelector('.display__time-left');
final endTime = querySelector('.display__end-time');
final buttons = querySelectorAll('[data-time]');

void timer(seconds) {
  // clear any existing timers
  countdown.cancel();

  final now = DateTime.now().millisecondsSinceEpoch;
  final then = now + seconds * 1000;
  displayTimeLeft(seconds);
  displayEndTime(then);
  countdown = Timer.periodic(Duration(seconds: 1), (Timer t) {
    final secondsLeft =
        ((then - DateTime.now().millisecondsSinceEpoch) / 1000).round();
    // check if we should stop it!
    if (secondsLeft < 0) {
      countdown.cancel();
      return;
    }
    // display it
    displayTimeLeft(secondsLeft);
  });
}

void displayTimeLeft(seconds) {
  final minutes = (seconds / 60).floor();
  final remainderSeconds = seconds % 60;
  final display =
      '${minutes}:${remainderSeconds < 10 ? '0' : ''}${remainderSeconds}';
  document.title = display;
  timerDisplay.text = display;
}

void displayEndTime(timestamp) {
  final end = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
  final hour = end.hour;
  final adjustedHour = hour > 12 ? hour - 12 : hour;
  final minutes = end.minute;
  endTime.text =
      'Be Back At ${adjustedHour}:${minutes < 10 ? '0' : ''}${minutes}';
}

void startTimer(Event e) {
  final target = e.currentTarget as HtmlElement;
  final seconds = int.parse(target.dataset['time']);
  timer(seconds);
}

void main() {
  buttons.forEach((button) => button.addEventListener('click', startTimer));

  final form = document.getElementsByName('customForm') as FormElement;

  form.addEventListener('submit', (Event e) {
    e.preventDefault();
    final mins = (document.getElementsByName('minutes') as InputElement).value;
    print(mins);
    timer(mins * 60);
    form.reset();
  });
}
