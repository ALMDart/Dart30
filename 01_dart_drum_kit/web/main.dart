import 'dart:html';

void removeTransition(Event e) {
  if((e as TransitionEvent).propertyName != 'transform') return;
  e.target as HtmlElement ..classes.remove('playing');
}

void playSound(Event e) {
  final key = e as KeyboardEvent;
  final audio = querySelector('audio[data-key="${key.keyCode}"]') as AudioElement;
  final keyE = querySelector('div[data-key="${key.keyCode}"]') as HtmlElement;
  if(audio == null) return;
  keyE.classes.add('playing');
  audio.currentTime = 0;
  audio.play();
}

void main() {
  querySelectorAll('.key').forEach((e) => e.addEventListener('transitionend', removeTransition));
  window.addEventListener('keydown', playSound);
}
