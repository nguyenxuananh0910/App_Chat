enum MessageType {
  text(1),
  image(2),
  video(3),
  file(4);

  final int value;

  const MessageType(this.value);
}
