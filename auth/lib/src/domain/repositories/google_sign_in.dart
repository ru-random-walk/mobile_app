abstract interface class GoogleSignInRepository {
  Future<String> getGoogleAccessToken();
}