enum MessageType {
  text,
  requestForWalk,
  unknown;

  static MessageType fromString(String type) {
    switch (type) {
      case 'text':
        return MessageType.text;
      case 'requestForWalk':
        return MessageType.requestForWalk;
      default:
        return MessageType.unknown;
    }
  }
}
