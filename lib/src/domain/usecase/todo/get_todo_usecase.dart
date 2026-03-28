import '../../../core/utils/typedef.dart';
import '../../entities/todo.dart';
import '../../repositories/todo_repository.dart';

class GetTodo {
  final TodoRepository _repository;

  GetTodo(this._repository);

  ResultFuture<TodoEntity> call() async {
    return await _repository.get();
  }
}
