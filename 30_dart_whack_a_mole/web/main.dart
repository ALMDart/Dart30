import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'dart:math';

final holes = querySelectorAll('.hole');
final scoreBoard = querySelector('.score') as HtmlElement;
final moles = querySelectorAll('.mole');
var lastHole;
var timeUp = false;
var score = 0;
final r = Random();

int randomTime(min, max) {
  return (r.nextDouble() * (max - min) + min).round();
}

HtmlElement randomHole(holes) {
  final idx = (r.nextDouble() * holes.length).floor();
  final hole = holes[idx];
  if (hole == lastHole) {
    print('Ah nah thats the same one bud');
    return randomHole(holes);
  }
  lastHole = hole;
  return hole;
}

void peep() {
  final time = randomTime(200, 1000);
  final hole = randomHole(holes);
  hole.classes.add('up');
  Timer(Duration(milliseconds: time), () {
    hole.classes.remove('up');
    if (!timeUp) peep();
  });
}

void startGame() {
  scoreBoard.text = '${0}';
  timeUp = false;
  score = 0;
  peep();
  Timer(Duration(seconds: 10), () => timeUp = true);
}

void bonk(Event e) {
  if(!e.isTrusted) return; // cheater!
  final target = e.currentTarget as HtmlElement;
  score++;
  target.parent.classes.remove('up');
  scoreBoard.text = '${score}';
}


void main() {
  moles.forEach((mole) => mole.addEventListener('click', bonk));
  context['startGame'] = startGame;
}
