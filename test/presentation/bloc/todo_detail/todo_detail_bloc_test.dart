// ignore_for_file: avoid_print
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_bloc_todo_app/src/core/error/failures.dart';
import 'package:simple_bloc_todo_app/src/domain/entities/todo.dart';
import 'package:simple_bloc_todo_app/src/domain/usecase/todo/detail_todo_usecase.dart';
import 'package:simple_bloc_todo_app/src/presentation/bloc/todo_detail/todo_detail_bloc.dart';
import 'package:simple_bloc_todo_app/src/presentation/bloc/todo_detail/todo_detail_event.dart';
import 'package:simple_bloc_todo_app/src/presentation/bloc/todo_detail/todo_detail_state.dart';

class MockDetailTodo extends Mock implements DetailTodo {}

void main() {
  late TodoDetailBloc bloc;
  late MockDetailTodo mockDetailTodo;

  setUp(() {
    mockDetailTodo = MockDetailTodo();
    bloc = TodoDetailBloc(detailTodo: mockDetailTodo);
  });

  const tId = 1;
  const tTodoEntity = TodoEntity(
    todos: [Todo(id: 1, todo: 'Test Todo', completed: false, userId: 1)],
    total: 1,
    skip: 0,
    limit: 10,
  );

  test('initial state should be TodoDetailInitial', () {
    print('--- Running Test: TodoDetailBloc Initial State ---');
    expect(bloc.state, const TodoDetailInitial());
    print('Result: SUCCESS\n');
  });

  blocTest<TodoDetailBloc, TodoDetailState>(
    'should emit [TodoDetailLoading, TodoDetailSuccess] when GetDetailTodoEvent is added',
    build: () {
      print('--- Running Test: TodoDetailBloc Success Flow ---');
      when(
        () => mockDetailTodo(any()),
      ).thenAnswer((_) async => const Right(tTodoEntity));
      return bloc;
    },
    act: (bloc) => bloc.add(const GetDetailTodoEvent(id: tId)),
    expect: () => [
      const TodoDetailLoading(),
      const TodoDetailSuccess(tTodoEntity),
    ],
    verify: (_) {
      verify(() => mockDetailTodo(tId)).called(1);
      print('Result: SUCCESS\n');
    },
  );

  blocTest<TodoDetailBloc, TodoDetailState>(
    'should emit [TodoDetailLoading, TodoDetailError] when GetDetailTodoEvent fails',
    build: () {
      print('--- Running Test: TodoDetailBloc Error Flow ---');
      when(
        () => mockDetailTodo(any()),
      ).thenAnswer((_) async => const Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(const GetDetailTodoEvent(id: tId)),
    expect: () => [
      const TodoDetailLoading(),
      const TodoDetailError('Server Error'),
    ],
    verify: (_) {
      print('Result: SUCCESS\n');
    },
  );
}
