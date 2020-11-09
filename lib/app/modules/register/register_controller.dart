import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_firebase/app/modules/home/models/todo_model.dart';
import 'package:todo_firebase/app/shared/auth_controller.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  AuthController auth = Modular.get();

  @observable
  bool loading = false;

  @action
  backtoLogin() {
    Modular.to.pushReplacementNamed('/login');
  }

  @observable
  String email = '';

  @observable
  String password = '';
  @observable
  String name = '';

  @computed
  bool get enableButton => email.isNotEmpty && password.isNotEmpty;

  @action
  void setEmail(String email) => this.email = email;

  @action
  void setPassword(String password) => this.password = password;

  @action
  void setName(String name) => this.name = name;

  @action
  Future registerEmailPassword() async {
    try {
      loading = true;
      await auth.registerWithEmailAndPassword(email, password);
      UserModel(uid: auth.user.uid, nome: name).save();
      Modular.to.pushReplacementNamed('/home');
    } catch (e) {
      loading = false;
    }
  }
}
