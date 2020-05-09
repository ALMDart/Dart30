import 'dart:async';
import 'dart:html';

class Debouncer<T> {
  Debouncer(this.duration, this.onValue);
  final Duration duration;
  void Function(T value) onValue;
  T _value;
  Timer _timer;
  T get value => _value;
  void nextValue(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}

final sliderImages = querySelectorAll('.slide-in');

void checkSlide(dynamic d) {
  sliderImages.forEach((sliderImage) {
    // half way through the image
    final target = sliderImage as ImageElement;
    final slideInAt = (window.scrollY + window.innerHeight) - target.height / 2;
    // bottom of the image
    final imageBottom = target.offsetTop + target.height;
    final isHalfShown = slideInAt > target.offsetTop;
    final isNotScrolledPast = window.scrollY < imageBottom;
    if (isHalfShown && isNotScrolledPast) {
      sliderImage.classes.add('active');
    } else {
      sliderImage.classes.remove('active');
    }
  });
}

void main() {
  final deb = Debouncer<dynamic>(Duration(milliseconds: 20), checkSlide);
  window.addEventListener('scroll', deb.nextValue);
}
