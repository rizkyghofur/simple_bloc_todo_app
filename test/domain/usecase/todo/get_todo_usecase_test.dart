import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_bloc_todo_app/src/domain/entities/todo.dart';
import 'package:simple_bloc_todo_app/src/domain/repositories/todo_repository.dart';
import 'package:simple_bloc_todo_app/src/domain/usecase/todo/get_todo_usecase.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late GetTodo usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetTodo(mockTodoRepository);
  });

  const tTodoEntity = TodoEntity(todos: [], total: 0, skip: 0, limit: 0);

  test('should get todos from the repository', () async {
    // arrange
    when(
      () => mockTodoRepository.get(
        limit: any(named: 'limit'),
        skip: any(named: 'skip'),
      ),
    ).thenAnswer((_) async => const Right(tTodoEntity));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, const Right(tTodoEntity));
    verify(() => mockTodoRepository.get(limit: 10, skip: 0)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
