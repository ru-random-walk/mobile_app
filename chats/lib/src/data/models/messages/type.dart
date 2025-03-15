enum MessageType {
  text('text'),
  requestForWalk('request_for_walk'),
  unknown('unknown');

  final String textValue;

  const MessageType(this.textValue);

  static MessageType fromString(String type) {
    switch (type) {
      case 'text':
        return MessageType.text;
      case 'request_for_walk':
        return MessageType.requestForWalk;
      default:
        return MessageType.unknown;
    }
  }
}
