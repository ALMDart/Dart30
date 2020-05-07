import 'dart:html';
import 'dart:js';

var pressed = <String>[];
const secretCode = 'wesbos';

void handleKeyup(Event e) {
  final target = e as KeyboardEvent;
  print(target.key);
  pressed.add(target.key);
  if(pressed.length > secretCode.length) {
    pressed = pressed.sublist(
        pressed.length - secretCode.length);
  }
  if (pressed.join('').contains(secretCode)) {
    print('DING DING!');
    context['cornify_add']();
  }
  print(pressed);
}

void main() {
  window.addEventListener('keyup', handleKeyup);
}
