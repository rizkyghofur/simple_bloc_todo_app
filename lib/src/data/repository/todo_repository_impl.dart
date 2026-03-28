import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/typedef.dart';
import '../../domain/entities/todo.dart';
import '../datasource/todo_remote_datasource.dart';
import '../../domain/repositories/todo_repository.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<TodoEntity> get() async {
    try {
      final result = await remoteDataSource.get();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  ResultFuture<TodoEntity> detail(int id) async {
    try {
      final result = await remoteDataSource.detail(id);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  ResultFuture<TodoEntity> search(TodoModel data, String query) async {
    try {
      final result = data.todos
          .where((e) => e.todo.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Right(
        TodoModel(
          todos: result,
          total: data.total,
          skip: data.skip,
          limit: data.limit,
        ).toEntity(),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
