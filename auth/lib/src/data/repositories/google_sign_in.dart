import 'package:auth/src/data/repositories/google_client_id.dart';
import 'package:auth/src/domain/repositories/google_sign_in.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

const _userInfoScope = 'https://www.googleapis.com/auth/userinfo';

class GoogleSignInRepositoryI implements GoogleSignInRepository {
  @override
  Future<String> getGoogleAccessToken() async {
    final scopes = [
      '$_userInfoScope.email',
      '$_userInfoScope.profile',
    ];
    final gogleSignIn = GoogleSignIn(
      scopes: scopes,
      clientId: kIsWeb ? googleClientId : null,
    );
    final acc = await gogleSignIn.signIn();
    final auth = await acc?.authentication;
    final token = auth?.accessToken;
    if (token == null) {
      throw BaseError(
        'Google token is null',
        StackTrace.current,
      );
    }
    return token;
  }
}
