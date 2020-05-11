import 'dart:html';

final triggers = querySelectorAll('a');
final highlight = document.createElement('span');

void highlightLink(Event e) {
  final target = e.currentTarget as HtmlElement;
  final linkCoords = target.getBoundingClientRect();
  print(linkCoords);
  final coords = {
    'width': linkCoords.width,
    'height': linkCoords.height,
    'top': linkCoords.top + window.scrollY,
    'left': linkCoords.left + window.scrollX
  };

  highlight.style.width = '${coords['width']}px';
  highlight.style.height = '${coords['height']}px';
  highlight.style.transform = 'translate(${coords['left']}px, ${coords['top']}px)';

}

void main() {
  highlight.classes.add('highlight');
  document.body.append(highlight);
  triggers.forEach((a) => a.addEventListener('mouseenter', highlightLink));
}
