int calculateReadTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  //speed =d/t
  final readingTime = wordCount / 225;
  //ceil rounds up to the nearest integer
  return readingTime.ceil();
}
