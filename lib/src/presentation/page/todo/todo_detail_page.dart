import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../../injection_container.dart';
import '../../bloc/todo_detail/todo_detail_bloc.dart';
import '../../bloc/todo_detail/todo_detail_event.dart';
import '../../bloc/todo_detail/todo_detail_state.dart';

import '../../widgets/common/error_state_widget.dart';
import '../../widgets/common/loading_state_widget.dart';
import '../../widgets/todo/todo_detail_content.dart';

class TodoDetailPage extends StatelessWidget {
  final int id;
  const TodoDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Task Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          BlocBuilder<TodoDetailBloc, TodoDetailState>(
            bloc: sl<TodoDetailBloc>(),
            builder: (context, state) {
              if (state is TodoDetailSuccess) {
                return IconButton(
                  icon: const Icon(Icons.share_rounded),
                  onPressed: () {
                    final todo = state.data.todos.first;
                    SharePlus.instance.share(
                      ShareParams(
                        text:
                            'Check out this task: ${todo.todo}\nStatus: ${todo.completed ? "Completed" : "Pending"}\n\nOpen in app: simplebloc://todo-detail/${todo.id}',
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: PopScope(
        canPop:
            false, // We handle the pop manually to ensure the stack is respected
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          if (context.canPop()) {
            context.pop();
          } else {
            // If opened via deeplink without history, go to home
            context.go('/');
          }
        },
        child: BlocBuilder<TodoDetailBloc, TodoDetailState>(
          bloc: sl<TodoDetailBloc>()..add(GetDetailTodoEvent(id: id)),
          builder: (context, state) {
            if (state is TodoDetailLoading) {
              return const LoadingStateWidget();
            }

            if (state is TodoDetailError) {
              return ErrorStateWidget(
                message: state.message,
                onRetry: () {
                  sl<TodoDetailBloc>().add(GetDetailTodoEvent(id: id));
                },
              );
            }

            if (state is TodoDetailSuccess) {
              final todo = state.data.todos.first;
              return TodoDetailContent(todo: todo);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
