import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_bloc_todo_app/src/data/models/todo_model.dart';
import 'package:simple_bloc_todo_app/src/domain/entities/todo.dart';
import 'package:simple_bloc_todo_app/src/domain/repositories/todo_repository.dart';
import 'package:simple_bloc_todo_app/src/domain/usecase/todo/search_todo_usecase.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

class FakeTodoModel extends Fake implements TodoModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTodoModel());
  });

  late SearchTodo usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = SearchTodo(mockTodoRepository);
  });

  const tTodoEntity = TodoEntity(todos: [], total: 0, skip: 0, limit: 0);

  final tTodoModel = TodoModel.fromEntity(tTodoEntity);
  const tQuery = 'test';

  test('should call search from the repository', () async {
    // arrange
    when(
      () => mockTodoRepository.search(any(), any()),
    ).thenAnswer((_) async => const Right(tTodoEntity));

    // act
    final result = await usecase(tTodoModel, tQuery);

    // assert
    expect(result, const Right(tTodoEntity));
    verify(() => mockTodoRepository.search(tTodoModel, tQuery)).called(1);
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
