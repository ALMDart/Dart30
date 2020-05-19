import 'dart:async';
import 'dart:html';

final triggers = querySelectorAll('.cool > li');
final background = querySelector('.dropdownBackground');
final nav = querySelector('.top');

void handleEnter(Event e) {
  final target = e.currentTarget as HtmlElement;
  target.classes.add('trigger-enter');
  Timer(Duration(milliseconds: 150), () {
    if(target.classes.contains('trigger-enter')) {
      target.classes.add('trigger-enter-active');
    }
  });
  background.classes.add('open');

  final dropdown = target.querySelector('.dropdown');
  final dropdownCoords = dropdown.getBoundingClientRect();
  final navCoords = nav.getBoundingClientRect();

  final coords = <String, double>{
    'height': dropdownCoords.height,
    'width': dropdownCoords.width,
    'top': dropdownCoords.top - navCoords.top,
    'left': dropdownCoords.left - navCoords.left
  };

  background.style.setProperty('width', '${coords['width']}px');
  background.style.setProperty('height', '${coords['height']}px');
  background.style.setProperty(
      'transform', 'translate(${coords['left']}px, ${coords['top']}px)');
}

void handleLeave(Event e) {
  final target = e.currentTarget as HtmlElement;
  target.classes.remove('trigger-enter');
  target.classes.remove('trigger-enter-active');
  background.classes.remove('open');
}

void main() {
  triggers.forEach(
      (trigger) => trigger.addEventListener('mouseenter', handleEnter));
  triggers.forEach(
      (trigger) => trigger.addEventListener('mouseleave', handleLeave));
}
