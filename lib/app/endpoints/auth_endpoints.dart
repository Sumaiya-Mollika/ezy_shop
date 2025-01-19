import '../network/environment.dart';

class AuthEndPoints {
  static String signInUrl() {
    return '${getBaseUrl()}/auth/signin';
  }
}
