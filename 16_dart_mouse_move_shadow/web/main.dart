import 'dart:html';

final hero = document.querySelector('.hero');
final text = hero.querySelector('h1');
const walk = 500; // 500px

void shadow(Event e) {
  final target = e as MouseEvent;
  final width = hero.offsetWidth;
  final height = hero.offsetHeight;
  var x = target.offset.x;
  var y = target.offset.y;
  final currentTarget = e.target as HtmlElement;

  x = x + currentTarget.offset.left;
  y = y + currentTarget.offset.top;

  final xWalk = ((x / width * walk) - (walk / 2)).round();
  final yWalk = ((y / height * walk) - (walk / 2)).round();
  text.style.textShadow = '''
  ${xWalk}px ${yWalk}px 0 rgba(255,0,255,0.7),
  ${xWalk * -1}px ${yWalk}px 0 rgba(0,255,255,0.7),
  ${yWalk}px ${xWalk * -1}px 0 rgba(0,255,0,0.7),
  ${yWalk * -1}px ${xWalk}px 0 rgba(0,0,255,0.7)
  ''';
}

void main() {
  hero.addEventListener('mousemove', shadow);
}
