import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_firebase/app/shared/auth_controller.dart';

class TodoModel {
  String title;
  bool check;
  int position;
  DocumentReference reference;

  TodoModel({this.reference, this.title = '', this.check = false});

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    return TodoModel(
      check: doc['check'],
      title: doc['title'],
      reference: doc.reference,
    );
  }
  Future save() async {
    final auth = Modular.get<AuthController>();
    if (reference == null) {
      //ordenar
      int total = (await Firestore.instance
              .collection('user')
              .document(auth.user.uid)
              .collection('ToDos')
              .getDocuments())
          .documents
          .length;

      // add novo item
      reference = await Firestore.instance
          .collection('user')
          .document(auth.user.uid)
          .collection('ToDos')
          .add({
        'title': title,
        'check': check,
        'position': total + 1,
      });
    } else {
      //update
      reference.updateData({
        'title': title,
        'check': check,
      });
    }
  }

  Future delete() {
    return reference.delete();
  }
}

class UserModel {
  String uid;
  String nome;

  UserModel({this.uid, this.nome});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      nome: doc['nome'],
      uid: doc['uid'],
    );
  }

  save() {
    Firestore.instance.collection('user').document(uid).setData({
      'nome': nome,
    });
  }
}
