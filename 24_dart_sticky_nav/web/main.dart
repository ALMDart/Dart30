import 'dart:html';

// Not a ton of code, but hard to
final nav = querySelector('#main');
final topOfNav = nav.offsetTop;

void fixNav(Event e) {
  if (window.scrollY >= topOfNav) {
    document.body.style.paddingTop = '${nav.offsetHeight}px';
    document.body.classes.add('fixed-nav');
  } else {
    document.body.classes.remove('fixed-nav');
    document.body.style.paddingTop = '0';
  }
}

void main() {
  window.addEventListener('scroll', fixNav);
}
