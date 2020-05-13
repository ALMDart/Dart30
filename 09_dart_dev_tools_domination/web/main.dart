import 'dart:convert';
import 'dart:html';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

class Dog {
  final String name;
  final int age;

  const Dog(this.name, this.age);
}

final List<Dog> dogs = [Dog('Snickers', 2), Dog('hugo', 8)];


void makeGreen() {
  final p = querySelector('p');
  p.style.color = '#BADA55';
  p.style.fontSize = '50px';
  print('yo');
}

void main() {
  // Regular
  //  print
  print('hello');

  setProperty(window, 'makeGreen', allowInterop(makeGreen));

  // Interpolated (Doesn't work)
//    print('Hello I am a %s string!', '💩');

  // Styled
  // print('%c I am some great text', 'font-size:50px; background:red; text-shadow: 10px 10px 0 blue')

  // warning!
  window.console.warn('OH NOOO');

  // Error :|
  window.console.warn('Shit!');

  // Info
  window.console.warn('Crocodiles eat 3-4 people per year');

  // Testing
  final p = querySelector('p');

  // Doesn't work currently
  // window.console.assertCondition(p.classes.contains('ouch'), 'That is wrong!');

  // clearing
  window.console.clear(null);

  // Viewing DOM Elements
  print(p);
  window.console.dir(p);

  window.console.clear(null);

  // Grouping together
  dogs.forEach((Dog dog) {
    window.console.groupCollapsed('${dog.name}');
    print('his is ${dog.name}');
    print('${dog.name} is ${dog.age} years old');
    print('${dog.name} is ${dog.age * 7} dog years old');
    window.console.groupEnd();
  });

  // counting

  window.console.count('Wes');
  window.console.count('Wes');
  window.console.count('Steve');
  window.console.count('Steve');
  window.console.count('Wes');
  window.console.count('Steve');
  window.console.count('Wes');
  window.console.count('Steve');
  window.console.count('Steve');
  window.console.count('Steve');
  window.console.count('Steve');
  window.console.count('Steve');

  // timing
  window.console.time('fetching data');
    HttpRequest.request('https://api.github.com/users/wesbos', method: 'GET')
      .then((data) => jsonDecode(data.responseText))
      .then((data) {
    window.console.timeEnd('fetching data');
    print(data);
  });

  window.console.table(dogs);
}
