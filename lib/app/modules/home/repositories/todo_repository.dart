import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_firebase/app/modules/home/models/todo_model.dart';
import 'package:todo_firebase/app/modules/home/repositories/todo_repository_interface.dart';
import 'package:todo_firebase/app/shared/auth_controller.dart';

class TodoRepository implements ITodoRepository {
  final Firestore firestore;

  TodoRepository(this.firestore);
  final auth = Modular.get<AuthController>();

  @override
  Stream<List<TodoModel>> getTodos() {
    return firestore
        .collection('user')
        .document(auth.user.uid)
        .collection('ToDos')
        .orderBy('position')
        .snapshots()
        .map((query) {
      return query.documents.map((doc) {
        return TodoModel.fromDocument(doc);
      }).toList();
    });
  }

  @override
  Stream<List<TodoModel>> getForAll() {
    return firestore
        .collection('ForAll')
        .orderBy('position')
        .snapshots()
        .map((query) {
      return query.documents.map((doc) {
        return TodoModel.fromDocument(doc);
      }).toList();
    });
  }

  @override
  Future<UserModel> userData() async {
    print(auth.user.uid);
    return await Firestore.instance
        .collection('user')
        .document(auth.user.uid)
        .get()
        .then((doc) {
      print(doc.data);
      return UserModel.fromDocument(doc);
    });
  }
}
