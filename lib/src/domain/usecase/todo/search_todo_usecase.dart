import '../../../core/utils/typedef.dart';
import '../../../data/models/todo_model.dart';
import '../../entities/todo.dart';
import '../../repositories/todo_repository.dart';

class SearchTodo {
  final TodoRepository _repository;

  SearchTodo(this._repository);

  ResultFuture<TodoEntity> call(TodoModel data, String query) async {
    return await _repository.search(data, query);
  }
}
