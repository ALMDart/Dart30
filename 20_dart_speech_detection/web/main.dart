import 'dart:html';

void main() {
  final recognition = SpeechRecognition();

  recognition.interimResults = true;
  recognition.lang = 'en-US';

  var p = document.createElement('p');
  final words = querySelector('.words');
  words.append(p);

  recognition.addEventListener('result', (Event e) {
    final target = e as SpeechRecognitionEvent;
    final results = List.from(target.results);
    final transcript = results
        .map((result) => result.item(0))
        .map((result) => result.transcript)
        .join('');

    final poopScript = transcript.replaceAll(
        RegExp(r'poop|poo|shit|dump', caseSensitive: false), '💩');
    p.text = poopScript;

    if (results[0].isFinal) {
      p = document.createElement('p');
      words.append(p);
    }
  });

  recognition.addEventListener('end', (e) => recognition.start());
  recognition.start();
}
