import 'dart:html';

final slider = document.querySelector('.items');
var isDown = false;
var startX;
var scrollLeft;

void main() {
  slider.addEventListener('mousedown', (Event e) {
    final target = e as MouseEvent;
    isDown = true;
    slider.classes.add('active');
    startX = target.page.x - slider.offsetLeft;
    scrollLeft = slider.scrollLeft;
  });

  slider.addEventListener('mouseleave', (Event e) {
    isDown = false;
    slider.classes.remove('active');
  });

  slider.addEventListener('mouseup', (Event e) {
    isDown = false;
    slider.classes.remove('active');
  });

  slider.addEventListener('mousemove', (Event e) {
    final target = e as MouseEvent;
    if (!isDown) return; // stop the fn from running
    e.preventDefault();
    final x = target.page.x - slider.offsetLeft;
    final walk = (x - startX) * 3;
    slider.scrollLeft = scrollLeft - walk;
  });
}
