import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
import 'package:flutter/material.dart';

part 'text.dart';
part 'invitation.dart';
part 'invitation_status.dart';

sealed class MessageEntity {
  final DateTime timestamp;
  final bool isMy;
  final bool isChecked;

  MessageEntity({
    required this.isChecked,
    required this.timestamp,
    required this.isMy,
  });
}


