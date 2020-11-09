import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key key, this.title = "Register"}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState
    extends ModularState<RegisterPage, RegisterController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.exit_to_app), onPressed: controller.backtoLogin),
        title: Text('Registro'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: controller.setName,
              decoration: InputDecoration(hintText: "Seu Nome"),
              keyboardType: TextInputType.name,
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
            Observer(
                name: 'LoginButton',
                builder: (context) {
                  return RaisedButton(
                    onPressed: controller.registerEmailPassword,
                    child: Text(
                      "Registrar-se",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                }),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
