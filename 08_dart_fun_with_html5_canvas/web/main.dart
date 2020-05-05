import 'dart:html';

final canvas = document.querySelector('#draw') as CanvasElement;
final ctx = canvas.getContext('2d') as CanvasRenderingContext2D;

void main() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  ctx.strokeStyle = '#BADA55';
  ctx.lineJoin = 'round';
  ctx.lineCap = 'round';
  ctx.lineWidth = 100;
// ctx.globalCompositeOperation = 'multiply';

  var isDrawing = false;
  var lastX = 0;
  var lastY = 0;
  var hue = 0;
  var direction = true;

  void draw(Event e) {
    if (!isDrawing) return; // stop the fn from running when they are not moused down
    final target = e as MouseEvent;
    print(e);
    ctx.strokeStyle = 'hsl(${hue}, 100%, 50%)';
    ctx.beginPath();
    // start from
    ctx.moveTo(lastX, lastY);
    // go to
    ctx.lineTo(target.offset.x, target.offset.y);
    ctx.stroke();
    lastX = target.offset.x;
    lastY = target.offset.y;

    hue++;
    if (hue >= 360) {
      hue = 0;
    }
    if (ctx.lineWidth >= 100 || ctx.lineWidth <= 1) {
      direction = !direction;
    }

    if (direction) {
      ctx.lineWidth++;
    } else {
      ctx.lineWidth--;
    }
  }

  canvas.addEventListener('mousedown', (Event e) {
    final target = e as MouseEvent;
    isDrawing = true;
    lastX = target.offset.x;
    lastY = target.offset.y;
  });

  canvas.addEventListener('mousemove', draw);
  canvas.addEventListener('mouseup', (e) => isDrawing = false);
  canvas.addEventListener('mouseout', (e) => isDrawing = false);
}
