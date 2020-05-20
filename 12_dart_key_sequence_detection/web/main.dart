@JS()
library key_sequence_detection;

import 'dart:html';
import 'package:js/js.dart';

var pressed = <String>[];
const secretCode = 'wesbos';

@JS('cornify_add')
external void cornify();

void handleKeyup(Event e) {
  if(e is! KeyboardEvent) return;
  final target = e as KeyboardEvent;
  print(target.key);
  pressed.add(target.key);
  if(pressed.length > secretCode.length) {
    pressed = pressed.sublist(
        pressed.length - secretCode.length);
  }
  if (pressed.join('').contains(secretCode)) {
    print('DING DING!');
    cornify();
  }
  print(pressed);
}

void main() {
  window.addEventListener('keyup', handleKeyup);
}
