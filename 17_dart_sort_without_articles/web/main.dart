import 'dart:html';

var bands = [
  'The Plot in You',
  'The Devil Wears Prada',
  'Pierce the Veil',
  'Norma Jean',
  'The Bled',
  'Say Anything',
  'The Midway State',
  'We Came as Romans',
  'Counterparts',
  'Oh, Sleeper',
  'A Skylit Drive',
  'Anywhere But Here',
  'An Old Dog'
];

String strip(bandName) {
  return bandName
      .replaceAll(RegExp(r'^(a |the |an )', caseSensitive: false), '')
      .trim();
}

void main() {
  bands.sort((a, b) => strip(a).compareTo(strip(b)) == 1 ? 1 : -1);
  querySelector('#bands').innerHtml =
      bands.map((band) => '<li>${band}</li>').join('');
  print(bands);
}
