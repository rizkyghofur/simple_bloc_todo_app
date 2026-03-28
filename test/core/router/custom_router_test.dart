// ignore_for_file: avoid_print
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_bloc_todo_app/src/core/router/custom_router.dart';
import 'package:simple_bloc_todo_app/src/presentation/bloc/todo_detail/todo_detail_bloc.dart';
import 'package:simple_bloc_todo_app/src/presentation/bloc/todo_detail/todo_detail_event.dart';
import 'package:simple_bloc_todo_app/src/injection_container.dart';

class MockTodoDetailBloc extends Mock implements TodoDetailBloc {}

class FakeGoRouterState extends Fake implements GoRouterState {
  @override
  final Uri uri;

  FakeGoRouterState(this.uri);
}

void main() {
  late MockTodoDetailBloc mockTodoDetailBloc;

  setUp(() {
    mockTodoDetailBloc = MockTodoDetailBloc();

    // Reset and Register Mock
    if (sl.isRegistered<TodoDetailBloc>()) {
      sl.unregister<TodoDetailBloc>();
    }
    sl.registerFactory<TodoDetailBloc>(() => mockTodoDetailBloc);

    // Stub mocktail any()
    registerFallbackValue(const GetDetailTodoEvent(id: 0));
  });

  group('CustomRouter Deeplink Redirect', () {
    test(
      'should return /todo-detail/1 when valid https://rizkyghofur.my.id/todo-detail/1 is provided',
      () {
        print('--- Running Test: Valid Deeplink ---');
        final uri = Uri.parse('https://rizkyghofur.my.id/todo-detail/1');
        print('Input URI: $uri');

        final state = FakeGoRouterState(uri);
        final result = CustomRouter.handleRedirect(state);

        print('Expected Result: /todo-detail/1');
        print('Actual Result: $result');

        expect(result, '/todo-detail/1');
        verify(
          () => mockTodoDetailBloc.add(const GetDetailTodoEvent(id: 1)),
        ).called(1);
        print('Result: SUCCESS\n');
      },
    );

    test(
      'should return /todo-detail/2 when valid https://www.rizkyghofur.my.id/todo-detail/2 is provided',
      () {
        print('--- Running Test: Valid Deeplink (WWW) ---');
        final uri = Uri.parse('https://www.rizkyghofur.my.id/todo-detail/2');
        print('Input URI: $uri');

        final state = FakeGoRouterState(uri);
        final result = CustomRouter.handleRedirect(state);

        print('Expected Result: /todo-detail/2');
        print('Actual Result: $result');

        expect(result, '/todo-detail/2');
        verify(
          () => mockTodoDetailBloc.add(const GetDetailTodoEvent(id: 2)),
        ).called(1);
        print('Result: SUCCESS\n');
      },
    );

    test('should return null when host is not rizkyghofur.my.id', () {
      print('--- Running Test: Invalid Host ---');
      final uri = Uri.parse('https://example.com/todo-detail/1');
      print('Input URI: $uri');

      final state = FakeGoRouterState(uri);
      final result = CustomRouter.handleRedirect(state);

      print('Expected Result: null');
      print('Actual Result: $result');

      expect(result, isNull);
      verifyNever(() => mockTodoDetailBloc.add(any()));
      print('Result: SUCCESS\n');
    });

    test('should return null when path does not contain /todo-detail/', () {
      print('--- Running Test: Invalid Path ---');
      final uri = Uri.parse('https://rizkyghofur.my.id/other-page/1');
      print('Input URI: $uri');

      final state = FakeGoRouterState(uri);
      final result = CustomRouter.handleRedirect(state);

      print('Expected Result: null');
      print('Actual Result: $result');

      expect(result, isNull);
      verifyNever(() => mockTodoDetailBloc.add(any()));
      print('Result: SUCCESS\n');
    });
  });
}
