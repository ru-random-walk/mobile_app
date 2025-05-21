import 'package:auth/auth.dart';

class RequestUser {
  final UserEntity user;
  final String confirmationId;

  RequestUser({required this.user, required this.confirmationId});
}
