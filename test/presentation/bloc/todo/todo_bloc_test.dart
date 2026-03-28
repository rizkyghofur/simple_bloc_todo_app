import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_bloc_todo_app/src/core/error/failures.dart';
import 'package:simple_bloc_todo_app/src/domain/entities/todo.dart';
import 'package:simple_bloc_todo_app/src/domain/usecase/todo/get_todo_usecase.dart';
import 'package:simple_bloc_todo_app/src/domain/usecase/todo/search_todo_usecase.dart';
import 'package:simple_bloc_todo_app/src/presentation/bloc/todo/todo_bloc.dart';
import 'package:simple_bloc_todo_app/src/presentation/bloc/todo/todo_event.dart';
import 'package:simple_bloc_todo_app/src/presentation/bloc/todo/todo_state.dart';

class MockGetTodo extends Mock implements GetTodo {}

class MockSearchTodo extends Mock implements SearchTodo {}

void main() {
  late TodoBloc bloc;
  late MockGetTodo mockGetTodo;
  late MockSearchTodo mockSearchTodo;

  setUp(() {
    mockGetTodo = MockGetTodo();
    mockSearchTodo = MockSearchTodo();
    bloc = TodoBloc(getTodo: mockGetTodo, searchTodo: mockSearchTodo);
  });

  const tTodoEntity = TodoEntity(todos: [], total: 0, skip: 0, limit: 0);

  test('initial state should be TodoInitial', () {
    expect(bloc.state, const TodoInitial());
  });

  blocTest<TodoBloc, TodoState>(
    'should emit [TodoLoading, TodoSuccess] when GetTodoEvent is added',
    build: () {
      when(
        () => mockGetTodo.execute(
          limit: any(named: 'limit'),
          skip: any(named: 'skip'),
        ),
      ).thenAnswer((_) async => const Right(tTodoEntity));
      return bloc;
    },
    act: (bloc) => bloc.add(const GetTodoEvent()),
    expect: () => [
      const TodoLoading(),
      const TodoSuccess(
        tTodoEntity,
        originalData: tTodoEntity,
        isSearch: false,
        hasReachedMax: true,
      ),
    ],
    verify: (_) {
      verify(() => mockGetTodo.execute(limit: 10, skip: 0)).called(1);
    },
  );

  blocTest<TodoBloc, TodoState>(
    'should emit [TodoLoading, TodoError] when GetTodoEvent fails',
    build: () {
      when(
        () => mockGetTodo.execute(
          limit: any(named: 'limit'),
          skip: any(named: 'skip'),
        ),
      ).thenAnswer((_) async => Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(const GetTodoEvent()),
    expect: () => [const TodoLoading(), const TodoError('Server Error')],
  );
}
