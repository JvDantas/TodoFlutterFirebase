import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_firebase/app/modules/home/models/todo_model.dart';
import 'package:todo_firebase/app/shared/auth_controller.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: controller.logoff,
        ),
        title: Observer(builder: (_) {
          return Container(
            child: controller.user.value != null
                ? Text('${controller.user.value.nome}' ?? '')
                : CircularProgressIndicator(),
          );
        }),
      ),
      body: Observer(builder: (_) {
        if (controller.forAllList.hasError) {
          return Center(
            child: RaisedButton(
              onPressed: controller.getList,
              child: Text('Error'),
            ),
          );
        }
        if (controller.all == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<TodoModel> list = controller.all;

        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              TodoModel model = list[index];
              return ListTile(
                title: Text(model.title),
                onTap: () {
                  _showDialog(model);
                },
                leading: IconButton(
                  icon: Icon(Icons.close, color: Colors.red[400]),
                  onPressed: model.delete,
                ),
                trailing: Checkbox(
                  value: model.check,
                  onChanged: (check) {
                    model.check = check;
                    model.save();
                  },
                ),
              );
            });
      }),
      floatingActionButton: (FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.add),
      )),
    );
  }

// Adicionar tarefa
  _showDialog([TodoModel model]) {
    model ??= TodoModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(model.title.isEmpty ? 'Novo' : 'Editar'),
            content: TextFormField(
              initialValue: model.title,
              onChanged: (value) => model.title = value,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Escreva sua tarefa...',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
              FlatButton(
                child: Text('Salvar'),
                onPressed: () async {
                  model.save();
                  Modular.to.pop();
                },
              ),
            ],
          );
        });
  }
}
