import 'dart:html';

/* Get Our Elements */
final player = document.querySelector('.player');
final video = player.querySelector('.viewer') as VideoElement;
final progress = player.querySelector('.progress');
final progressBar = player.querySelector('.progress__filled');
final toggle = player.querySelector('.toggle') as ButtonElement;
final skipButtons = player.querySelectorAll('[data-skip]');
final ranges = player.querySelectorAll('.player__slider');

/* Build out functions */
void togglePlay(Event e) {
  video.paused ? video.play() : video.pause();
}

void updateButton(Event e) {
  final icon = video.paused ? '►' : '❚ ❚';
  print(icon);
  toggle.text = icon;
}

void skip(Event e) {
  final target = e.currentTarget as ButtonElement;
  print(target);
  video.currentTime += num.parse(target.dataset['skip']);
}

void handleRangeUpdate(Event e) {
  final target = e.target as RangeInputElement;
  final val = num.parse(target.value);
  switch(target.name) {
    case 'volume': video.volume = val; break;
    case 'playbackRate': video.playbackRate = val; break;
  }
}

void handleProgress(Event e) {
  final percent = (video.currentTime / video.duration) * 100;
  progressBar.style.flexBasis = '${percent}%';
}

void scrub(Event e) {
  if(e is! MouseEvent) return;
  print((e as MouseEvent).offset);
  final scrubTime = ((e as MouseEvent).offset.x / progress.offsetWidth) * video.duration;
  video.currentTime = scrubTime;
}

void main() {
/* Hook up the event listeners */
  video.addEventListener('click', togglePlay);
  video.addEventListener('play', updateButton);
  video.addEventListener('pause', updateButton);
  video.addEventListener('timeupdate', handleProgress);

  toggle.addEventListener('click', togglePlay);
  skipButtons.forEach((button) => button.addEventListener('click', skip));
  ranges.forEach((range) => range.addEventListener('change', handleRangeUpdate));
  ranges.forEach((range) => range.addEventListener('mousemove', handleRangeUpdate));

  var mousedown = false;
  progress.addEventListener('click', scrub);
  document.addEventListener('mousemove', (e) => mousedown ? scrub(e) : null);
  progress.addEventListener('mousedown', (e) => mousedown = true);
  document.addEventListener('mouseup', (e) => mousedown = false);
}
