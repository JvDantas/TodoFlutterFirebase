import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_firebase/app/shared/repositories/auth_repository_interface.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository _authRepository = Modular.get();
  @observable
  FirebaseUser user;

  @observable
  //status inicial
  AuthStatus status = AuthStatus.loading;

  @action
  setUser(FirebaseUser value) {
    user = value;
    status = user == null ? AuthStatus.logoff : AuthStatus.login;
  }

  _AuthControllerBase() {
    _authRepository.getUser().then(setUser).catchError((e) {
      print('ERROR');
    });
  }

  @action
  Future loginWithGoogle() async {
    user = await _authRepository.getGoogleLogin();
  }

  @action
  Future signInWithEmailAndPassword(email, password) async {
    user = await _authRepository.signInWithEmailAndPassword(email, password);
  }

  @action
  Future registerWithEmailAndPassword(email, password) async {
    user = await _authRepository.registerWithEmailAndPassword(email, password);
  }

  @action
  Future logOut() {
    return _authRepository.getLogout();
  }
}

enum AuthStatus { loading, login, logoff }
