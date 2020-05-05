import 'dart:html';

void main() {
  final checkboxes = document.querySelectorAll('.inbox input[type="checkbox"]');

  var lastChecked;

  void handleCheck(Event e) {
    final click = e as MouseEvent;
    final box = e.target as CheckboxInputElement;
    // Check if they had the shift key down
    // AND check that they are checking it
    var inBetween = false;
    if (click.shiftKey && box.checked) {
      // go ahead and do what we please
      // loop over every single checkbox
      checkboxes.forEach((checkbox) {
        print(checkbox);
        if (checkbox == box || checkbox == lastChecked) {
          inBetween = !inBetween;
          print('Starting to check them in between!');
        }

        if (inBetween) {
          checkbox as CheckboxInputElement..checked = true;
        }
      });
    }
    lastChecked = box;
  }

  checkboxes
      .forEach((checkbox) => checkbox.addEventListener('click', handleCheck));
}
