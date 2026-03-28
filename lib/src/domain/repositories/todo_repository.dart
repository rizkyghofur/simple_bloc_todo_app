import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../data/models/todo_model.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, TodoEntity>> get();

  Future<Either<Failure, TodoEntity>> detail(int id);

  Future<Either<Failure, TodoEntity>> search(TodoModel data, String query);
}
