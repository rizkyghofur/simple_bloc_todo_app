import '../../../core/utils/typedef.dart';
import '../../entities/todo.dart';
import '../../repositories/todo_repository.dart';

class GetTodo {
  final TodoRepository _repository;

  GetTodo(this._repository);

  ResultFuture<TodoEntity> execute({int limit = 10, int skip = 0}) async {
    return await _repository.get(limit: limit, skip: skip);
  }
}
