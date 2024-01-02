import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/constants/utils.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/repository/todo_repo.dart';

final todoControllerProvider = StateNotifierProvider<TodoController, bool>((ref) {
  return TodoController(todoRepo: ref.watch(todoRepoProvider));
});

class TodoController extends StateNotifier<bool> {
  final TodoRepo _todoRepo;
  TodoController({required TodoRepo todoRepo})
      : _todoRepo = todoRepo,
        super(false);

  void createTodo({
    required String title,
    String? description,
    String? deadline,
    required BuildContext context,
  }) async {
    state = true;

    final body = jsonEncode({
      "title": title,
      "description": description,
      "deadline": deadline,
    });

    final result = await _todoRepo.createTodo(body);
    state = false;
    result.fold(
      (failure) => showSnackBar(context: context, message: failure.message),
      (success) {
        showSnackBar(context: context, message: success.message);
        context.pop();
      },
    );
  }

  Future<List<Todo>?> getTodos(BuildContext context) async {
    final result = await _todoRepo.getTodos();
    return result.fold(
      (failure) {
        if (failure.message.isNotEmpty) {
          showSnackBar(context: context, message: failure.message);
        }
        return null;
      },
      (todos) {
        return todos;
      },
    );
  }

  void deleteTodo({required String id, required BuildContext context}) async {
    final result = await _todoRepo.deleteTodo(id);
    result.fold(
      (failure) => showSnackBar(context: context, message: failure.message),
      (success) {
        showSnackBar(context: context, message: success.message);
      },
    );
  }

  void editTodo({
    required String id,
    required String title,
    String? description,
    required BuildContext context,
  }) async {
    state = true;

    final body = jsonEncode({
      "id": id,
      "title": title,
      "description": description,
    });

    final result = await _todoRepo.editTodo(body);
    state = false;
    result.fold(
      (failure) => showSnackBar(context: context, message: failure.message),
      (success) {
        showSnackBar(context: context, message: success.message);
        context.pop();
      },
    );
  }
}
