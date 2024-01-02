class ApiEndpoints {
  ApiEndpoints._();
  static const _baseUrl = "http://10.0.2.2:3000/v1/user";
  static const createTodo = "$_baseUrl/create-todo";
  static const getTodos = "$_baseUrl/get-todos";
  static const editTodo = "$_baseUrl/edit-todo";

  static String deleteTodo(String id) {
    return "$_baseUrl/delete-todo/id=$id";
  }
}
