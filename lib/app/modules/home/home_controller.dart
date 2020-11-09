import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_firebase/app/modules/home/models/todo_model.dart';
import 'package:todo_firebase/app/modules/home/repositories/todo_repository_interface.dart';
import 'package:todo_firebase/app/shared/auth_controller.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ITodoRepository repository;

  @observable
  ObservableStream<List<TodoModel>> todoList;
  ObservableStream<List<TodoModel>> forAllList;
  @observable
  ObservableFuture<UserModel> user;

  _HomeControllerBase(ITodoRepository this.repository) {
    getList();
    getForAll();
    userData();
  }

  @action
  getList() {
    todoList = repository.getTodos().asObservable();
  }

  @action
  getForAll() {
    forAllList = repository.getForAll().asObservable();
  }

  @computed
  List<TodoModel> get all {
    if (todoList.data != null && forAllList != null) {
      return forAllList.value.map((e) => e).toList() +
          todoList.value.map((e) => e).toList();
    }
  }

  @action
  logoff() async {
    await Modular.get<AuthController>().logOut();
    Modular.to.pushReplacementNamed('/login');
  }

  @action
  Future userData() async {
    user = repository.userData().asObservable();
    print(user.value.nome);
  }
}
