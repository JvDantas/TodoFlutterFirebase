// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  Computed<List<TodoModel>> _$allComputed;

  @override
  List<TodoModel> get all =>
      (_$allComputed ??= Computed<List<TodoModel>>(() => super.all,
              name: '_HomeControllerBase.all'))
          .value;

  final _$todoListAtom = Atom(name: '_HomeControllerBase.todoList');

  @override
  ObservableStream<List<TodoModel>> get todoList {
    _$todoListAtom.reportRead();
    return super.todoList;
  }

  @override
  set todoList(ObservableStream<List<TodoModel>> value) {
    _$todoListAtom.reportWrite(value, super.todoList, () {
      super.todoList = value;
    });
  }

  final _$logoffAsyncAction = AsyncAction('_HomeControllerBase.logoff');

  @override
  Future logoff() {
    return _$logoffAsyncAction.run(() => super.logoff());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic getList() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.getList');
    try {
      return super.getList();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getForAll() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.getForAll');
    try {
      return super.getForAll();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todoList: ${todoList},
all: ${all}
    ''';
  }
}
