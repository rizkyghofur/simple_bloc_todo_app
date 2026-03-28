import '../../../core/utils/typedef.dart';
import '../../entities/todo.dart';
import '../../repositories/todo_repository.dart';

class DetailTodo {
  final TodoRepository _repository;

  DetailTodo(this._repository);

  ResultFuture<TodoEntity> call(int id) async {
    return await _repository.detail(id);
  }
}
