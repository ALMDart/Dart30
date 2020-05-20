import 'dart:html';


void toggleOpen(Event e) {
  print('Hello');
  e.currentTarget as HtmlElement..classes.toggle('open');
}

void toggleActive(Event e) {
  if(e is! TransitionEvent) return;
  final tEvent = e as TransitionEvent;
  print(tEvent.propertyName);
  if (tEvent.propertyName.contains('flex')) {
    e.currentTarget as HtmlElement..classes.toggle('open-active');
  }
}

void main() {
  final panels = querySelectorAll('.panel');
  panels.forEach((panel) => panel.addEventListener('click', toggleOpen));
  panels.forEach((panel) => panel.addEventListener('transitionend', toggleActive));
}
