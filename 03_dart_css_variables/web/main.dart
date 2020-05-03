import 'dart:html';

void handleUpdate(Event e) {
  final target = e.target as InputElement;
  final attrs = target.attributes;
  var suffix;
  if(target.dataset.containsKey('sizing')) {
    suffix = target.dataset['sizing'];
  } else {
    suffix = '';
  }
  document.documentElement.style.setProperty('--${attrs['name']}', target.value + suffix);
}

void main() {
  final inputs = querySelectorAll('.controls input');
  inputs.forEach((input) => input.addEventListener('change', handleUpdate));
  inputs.forEach((input) => input.addEventListener('mousemove', handleUpdate));
}
