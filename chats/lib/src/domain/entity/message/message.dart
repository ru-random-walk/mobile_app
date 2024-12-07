part 'mine.dart';
part 'fellow.dart';
part 'text.dart';
part 'invitation.dart';
part 'invitation_status.dart';

sealed class MessageEntity {
  final DateTime timestamp;

  MessageEntity({
    required this.timestamp,
  });
}


