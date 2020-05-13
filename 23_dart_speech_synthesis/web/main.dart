@JS()
library speech_synthesis;

import 'dart:html';
import 'package:js/js.dart';

final msg = SpeechSynthesisUtterance();
List<SpeechSynthesisVoice> voices;
final voicesDropdown = document.querySelector('[name="voice"]');
final options = document.querySelectorAll('[type="range"], [name="text"]');
final speakButton = document.querySelector('#speak');
final stopButton = document.querySelector('#stop');

@JS('speechSynthesis.getVoices')
external List<SpeechSynthesisVoice> getVoices();

void populateVoices(Event e) {
  voices = getVoices();
  voicesDropdown.innerHtml = voices
      .where((voice) => voice.lang.contains('en'))
      .map((voice) =>
          '<option value="${voice.name}">${voice.name} (${voice.lang})</option>')
      .join('');
}

void setVoice(Event e) {
  final target = e.currentTarget as SelectElement;
  msg.voice = voices.singleWhere((voice) => voice.name == target.value);
  toggle(e);
}

void toggle(Event e, {bool startOver = true}) {
  window.speechSynthesis.cancel();
  if (startOver) {
    window.speechSynthesis.speak(msg);
  }
}

void setOption(Event e) {
  final target = e.currentTarget as RangeInputElement;
  print('${target.name}, ${target.value}');
  switch (target.name) {
    case 'rate':
      msg.rate = num.parse(target.value);
      break;
    case 'pitch':
      msg.pitch = num.parse(target.value);
      break;
  }
  toggle(e);
}

void main() {
  msg.text = (document.querySelector('[name="text"]') as TextAreaElement).value;
  window.speechSynthesis.addEventListener('voiceschanged', populateVoices);
  voicesDropdown.addEventListener('change', setVoice);
  options.forEach((option) => option.addEventListener('change', setOption));
  speakButton.addEventListener('click', toggle);
  stopButton.addEventListener('click', (e) => toggle(e, startOver: false));
}
