import 'package:jwt_decoder/jwt_decoder.dart';

mixin UtilsMixin {
  /// return true if a jwt is expired
  bool isJWTExpired(String jwt) {
    try { 
      return JwtDecoder.isExpired(jwt);
    } catch (e) {
      return true;
    }
  }
}
