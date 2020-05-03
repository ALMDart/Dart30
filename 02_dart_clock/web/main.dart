import 'dart:async';
import 'dart:html';

final secondsHand = querySelector('.second-hand') as DivElement;
final minsHand = querySelector('.min-hand') as DivElement;
final hoursHand = querySelector('.hour-hand') as DivElement;

void setDate() {
  final now = DateTime.now();

  final seconds = now.second;
  final secondsDegrees = ((seconds / 60) * 360) + 90;
  secondsHand.style.transform = 'rotate(${secondsDegrees}deg)';

  final mins = now.minute;
  final minsDegrees = ((mins / 60) * 360) + 90;
  minsHand.style.transform = 'rotate(${minsDegrees}deg)';

  final hour = now.minute;
  final hourDegrees = ((hour / 60) * 360) + 90;
  hoursHand.style.transform = 'rotate(${hourDegrees}deg)';
}

void main() {
  setDate();
  Timer.periodic(Duration(seconds: 1), (_) => setDate());
}
