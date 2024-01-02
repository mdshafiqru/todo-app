// ignore_for_file: void_checks

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:todoapp/constants/api.dart';
import 'package:todoapp/constants/api_endpoints.dart';
import 'package:todoapp/constants/utils.dart';
import 'package:todoapp/models/api_response.dart';
import 'package:todoapp/models/todo.dart';

import '../providers/common_provider.dart';

final todoRepoProvider = Provider((ref) => TodoRepo(api: ref.read(apiProvider)));

class TodoRepo {
  final API _api;
  TodoRepo({required API api}) : _api = api;

  FutureEither<Success> createTodo(String body) async {
    final result = await _api.postRequest(apiEndpoint: ApiEndpoints.createTodo, body: body, requireAuth: false);

    return result.fold(
      (failure) => left(failure),
      (Response response) {
        try {
          final json = jsonDecode(response.body);
          return right(Success(message: json['message'] ?? ""));
        } catch (e) {
          return left(Failure(message: ErrorMessage.failedToParseJson));
        }
      },
    );
  }

  FutureEither<List<Todo>> getTodos() async {
    final result = await _api.getRequest(apiEndpoint: ApiEndpoints.getTodos, requireAuth: false);

    return result.fold(
      (failure) => left(failure),
      (Response response) {
        try {
          final json = jsonDecode(response.body) as List<dynamic>;
          final todos = json.map((p) => Todo.fromMap(p)).toList();
          return right(todos);
        } catch (e) {
          return left(Failure(message: ErrorMessage.failedToParseJson));
        }
      },
    );
  }

  FutureEither<Success> deleteTodo(String id) async {
    final result = await _api.deleteRequest(apiEndpoint: ApiEndpoints.deleteTodo(id), requireAuth: false);

    return result.fold(
      (failure) => left(failure),
      (Response response) {
        try {
          final json = jsonDecode(response.body);
          return right(Success(message: json['message'] ?? ""));
        } catch (e) {
          return left(Failure(message: ErrorMessage.failedToParseJson));
        }
      },
    );
  }

  FutureEither<Success> editTodo(String body) async {
    final result = await _api.putRequest(apiEndpoint: ApiEndpoints.editTodo, body: body, requireAuth: false);

    return result.fold(
      (failure) => left(failure),
      (Response response) {
        try {
          final json = jsonDecode(response.body);
          return right(Success(message: json['message'] ?? ""));
        } catch (e) {
          return left(Failure(message: ErrorMessage.failedToParseJson));
        }
      },
    );
  }
}
