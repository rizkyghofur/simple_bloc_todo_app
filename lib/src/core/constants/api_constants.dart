class ApiConstants {
  static const String baseUrl = 'https://dummyjson.com';

  static const String getTodoEndpoint = '/todos';
  static String detailTodoEndpoint(int id) => '/todos/$id';

  static const Duration timeout = Duration(seconds: 30);
}
