import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_firebase/app/shared/auth_controller.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  AuthController auth = Modular.get();

  @observable
  bool loading = false;

  @action
  Future loginWithGoogle() async {
    try {
      loading = true;
      await auth.loginWithGoogle();
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      loading = false;
    }
  }

  @observable
  String email = '';

  @observable
  String password = '';

  @computed
  bool get enableButton => email.isNotEmpty && password.isNotEmpty;

  @action
  void setEmail(String email) => this.email = email;

  @action
  void setPassword(String password) => this.password = password;
  @action
  Future loginEmailPassword() async {
    try {
      loading = true;
      await auth.signInWithEmailAndPassword(email, password);
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      loading = false;
    }
  }
}
