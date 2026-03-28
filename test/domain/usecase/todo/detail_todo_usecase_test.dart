// ignore_for_file: avoid_print
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_bloc_todo_app/src/domain/entities/todo.dart';
import 'package:simple_bloc_todo_app/src/domain/repositories/todo_repository.dart';
import 'package:simple_bloc_todo_app/src/domain/usecase/todo/detail_todo_usecase.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late DetailTodo usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = DetailTodo(mockTodoRepository);
  });

  const tId = 1;
  const tTodoEntity = TodoEntity(
    todos: [Todo(id: 1, todo: 'Test Todo', completed: false, userId: 1)],
    total: 1,
    skip: 0,
    limit: 10,
  );

  test('should get todo detail from the repository', () async {
    print('--- Running Test: UseCase Detail Todo ---');
    // arrange
    when(
      () => mockTodoRepository.detail(any()),
    ).thenAnswer((_) async => const Right(tTodoEntity));

    // act
    final result = await usecase(tId);

    // assert
    expect(result, const Right(tTodoEntity));
    verify(() => mockTodoRepository.detail(tId)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
    print('Result: SUCCESS\n');
  });
}
