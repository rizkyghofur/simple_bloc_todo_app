import 'package:go_router/go_router.dart';
import '../../presentation/pages/todo/todo_detail_page.dart';
import '../../presentation/pages/todo/todo_get_page.dart';
import '../../injection_container.dart';
import '../../presentation/bloc/todo_detail/todo_detail_bloc.dart';
import '../../presentation/bloc/todo_detail/todo_detail_event.dart';

class CustomRouter {
  GoRouter get router => GoRouter(
    initialLocation: '/',
    redirect: (context, state) => handleRedirect(state),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const TodoGetPage(),
        routes: [
          GoRoute(
            path: 'todo-detail/:id',
            builder: (context, state) {
              final idString = state.pathParameters['id']!;
              final id = int.parse(idString);
              return TodoDetailPage(id: id);
            },
          ),
        ],
      ),
    ],
  );

  static String? handleRedirect(GoRouterState state) {
    final uri = state.uri;
    final host = uri.host;
    final path = uri.path;

    if ((host == 'rizkyghofur.my.id' || host == 'www.rizkyghofur.my.id') &&
        path.contains('/todo-detail/')) {
      final idString = path.split('/').last;

      if (idString.isNotEmpty) {
        final id = int.tryParse(idString);
        if (id != null) {
          sl<TodoDetailBloc>().add(GetDetailTodoEvent(id: id));
          return '/todo-detail/$idString';
        }
      }
    }
    return null;
  }
}
