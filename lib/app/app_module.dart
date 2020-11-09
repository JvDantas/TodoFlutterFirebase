import 'package:todo_firebase/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/app/app_widget.dart';
import 'package:todo_firebase/app/modules/home/home_module.dart';
import 'package:todo_firebase/app/shared/auth_controller.dart';
import 'package:todo_firebase/app/shared/repositories/auth_repository.dart';
import 'package:todo_firebase/app/splash/splash_page.dart';

import 'modules/login/login_module.dart';
import 'modules/register/register_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind<AuthRepository>((i) => AuthRepository()),
        Bind((i) => AuthController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => SplashPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/register', module: RegisterModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
