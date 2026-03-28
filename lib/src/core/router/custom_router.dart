import 'package:go_router/go_router.dart';
import '../../presentation/page/todo/todo_detail_page.dart';
import '../../presentation/page/todo/todo_get_page.dart';
import '../../injection_container.dart';
import '../../presentation/bloc/todo_detail/todo_detail_bloc.dart';
import '../../presentation/bloc/todo_detail/todo_detail_event.dart';

class CustomRouter {
  GoRouter get router => GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      if (state.uri.host == 'todo-detail') {
        final path = state.uri.path;
        if (path.isNotEmpty && path != '/') {
          final idString = path.replaceAll('/', '');
          final id = int.tryParse(idString);

          if (id != null) {
            sl<TodoDetailBloc>().add(GetDetailTodoEvent(id: id));
          }

          return '/todo-detail/$idString';
        }
      }
      return null;
    },
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
}
