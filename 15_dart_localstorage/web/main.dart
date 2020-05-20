import 'dart:convert';
import 'dart:html';

final addItems = document.querySelector('.add-items');
final itemsList = document.querySelector('.plates') as UListElement;
final items = jsonDecode(window.localStorage['items'] ?? '[]');

void populateList(List plates, platesList) {
  var i = 0;
  (platesList as HtmlElement).innerHtml = plates.map((plate) {
    return '''
      <li>
      <input type="checkbox" data-index=${i} id="item${i}" ${plate['done'] ? 'checked' : ''} />
      <label for="item${i++}">${plate['text']}</label>
      </li>
    ''';
  }).join('');
}

void addItem(Event e) {
  e.preventDefault();
  final target = e.currentTarget as FormElement;
  final text = (target.querySelector('[name=item]') as InputElement).value;
  final item = {'text': text, 'done': false};

  items.add(item);
  populateList(items, itemsList);
  window.localStorage['items'] = jsonEncode(items);
  target.reset();
}

void toggleDone(Event e) {
  if(e.target is! InputElement) return;
  final el = e.target as InputElement;
  final index = el.dataset['index'];
  items[index]['done'] = !items[index]['done'];
  window.localStorage['items'] = jsonEncode(items);
  populateList(items, itemsList);
}

void main() {
  addItems.addEventListener('submit', addItem);
  itemsList.addEventListener('click', toggleDone);

  populateList(items, itemsList);
}
