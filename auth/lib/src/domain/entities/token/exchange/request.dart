import 'package:auth/src/domain/entities/auth_type/base.dart';

class TokenExchangeRequestEntity {
  final AuthType authType;

  TokenExchangeRequestEntity(this.authType);
}
