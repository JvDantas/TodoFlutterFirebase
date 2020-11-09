import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_firebase/app/shared/auth_controller.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller
  AuthController _authController;
  @override
  void initState() {
    _authController = Modular.get<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 80),
              child: Center(
                child: Image.network(
                    'https://freeiconshop.com/wp-content/uploads/edd/clipboard-list-flat.png'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: controller.setEmail,
              decoration: InputDecoration(hintText: "Seu email"),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: controller.setPassword,
              decoration: InputDecoration(hintText: "Sua senha"),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: ButtonTheme(
              minWidth: 200.0,
              height: 40.0,
              child: RaisedButton(
                onPressed: () {
                  controller.loginEmailPassword();
                },
                child: Text("Login"),
              ),
            )),
            SizedBox(
              height: 10,
            ),
            // Center(
            //     child: ButtonTheme(
            //   minWidth: 200.0,
            //   height: 40.0,
            //   child: RaisedButton(
            //     onPressed: controller.loginWithGoogle,
            //     child: Text("Login With Google"),
            //     color: Colors.red[400],
            //   ),
            // )),
            // SizedBox(
            //   height: 10,
            // ),
            Center(
              child: ButtonTheme(
                minWidth: 200.0,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () {
                    Modular.to.pushReplacementNamed('/register');
                  },
                  child: Text("Register"),
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
