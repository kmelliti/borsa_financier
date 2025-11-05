import 'package:borsa_now_bis/core/services/auth_services.dart';

class LoginController  {


  final AuthService _authService;

  LoginController(this._authService);

  Future<void> signIn(String email, String password) {
    return _authService.signIn(email, password);
  }



}