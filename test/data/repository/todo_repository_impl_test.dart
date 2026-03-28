// ignore_for_file: avoid_print
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_bloc_todo_app/src/core/error/exceptions.dart';
import 'package:simple_bloc_todo_app/src/core/error/failures.dart';
import 'package:simple_bloc_todo_app/src/data/datasource/todo_remote_datasource.dart';
import 'package:simple_bloc_todo_app/src/data/models/todo_model.dart';
import 'package:simple_bloc_todo_app/src/data/repository/todo_repository_impl.dart';

class MockTodoRemoteDataSource extends Mock implements TodoRemoteDataSource {}

void main() {
  late TodoRepositoryImpl repository;
  late MockTodoRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTodoRemoteDataSource();
    repository = TodoRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tTodoModel = TodoModel(todos: [], total: 0, skip: 0, limit: 0);

  group('get', () {
    test('should return TodoEntity when call is successful', () async {
      print('--- Running Test: Repository Get Success ---');
      // arrange
      when(
        () => mockRemoteDataSource.get(
          limit: any(named: 'limit'),
          skip: any(named: 'skip'),
        ),
      ).thenAnswer((_) async => tTodoModel);

      // act
      final result = await repository.get(limit: 10, skip: 0);

      // assert
      expect(result, Right(tTodoModel.toEntity()));
      verify(() => mockRemoteDataSource.get(limit: 10, skip: 0)).called(1);
      print('Result: SUCCESS\n');
    });

    test(
      'should return ServerFailure when datasource throws ServerException',
      () async {
        print('--- Running Test: Repository Get Server Error ---');
        // arrange
        when(
          () => mockRemoteDataSource.get(
            limit: any(named: 'limit'),
            skip: any(named: 'skip'),
          ),
        ).thenThrow(ServerException('Server Error'));

        // act
        final result = await repository.get(limit: 10, skip: 0);

        // assert
        expect(result, const Left(ServerFailure('Server Error')));
        print('Result: SUCCESS\n');
      },
    );

    test(
      'should return NetworkFailure when datasource throws NetworkException',
      () async {
        print('--- Running Test: Repository Get Network Error ---');
        // arrange
        when(
          () => mockRemoteDataSource.get(
            limit: any(named: 'limit'),
            skip: any(named: 'skip'),
          ),
        ).thenThrow(NetworkException('Network Error'));

        // act
        final result = await repository.get(limit: 10, skip: 0);

        // assert
        expect(result, const Left(NetworkFailure('Network Error')));
        print('Result: SUCCESS\n');
      },
    );
  });
}
