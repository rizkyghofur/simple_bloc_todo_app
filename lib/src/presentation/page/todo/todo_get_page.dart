import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../injection_container.dart';
import '../../bloc/todo/todo_bloc.dart';
import '../../bloc/todo/todo_event.dart';
import '../../bloc/todo/todo_state.dart';

import 'package:go_router/go_router.dart';
import '../../widgets/common/error_state_widget.dart';
import '../../widgets/common/loading_state_widget.dart';
import '../../widgets/common/network_status_widget.dart';
import '../../widgets/todo/todo_empty_state_widget.dart';
import '../../widgets/todo/todo_item.dart';
import '../../widgets/todo/todo_search_bar.dart';

class TodoGetPage extends StatelessWidget {
  const TodoGetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: NetworkStatusWidget(
        child: BlocBuilder<TodoBloc, TodoState>(
          bloc: sl<TodoBloc>()..add(const GetTodoEvent()),
          builder: (context, state) {
            if (state is TodoLoading) {
              return const LoadingStateWidget();
            }

            if (state is TodoError) {
              return ErrorStateWidget(
                message: state.message,
                onRetry: () {
                  sl<TodoBloc>().add(const GetTodoEvent());
                },
              );
            }

            if (state is TodoSuccess) {
              final todos = state.data.todos;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: TodoSearchBar(
                      onChanged: (query) {
                        sl<TodoBloc>().add(SearchTodoEvent(query: query));
                      },
                    ),
                  ),
                  Expanded(
                    child: todos.isEmpty
                        ? const TodoEmptyStateWidget()
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              final todo = todos[index];
                              return TodoItem(
                                todo: todo,
                                onTap: () {
                                  context.push('/todo-detail/${todo.id}');
                                },
                              );
                            },
                          ),
                  ),
                ],
              );
            }

            return const Center(child: Text('Initial state'));
          },
        ),
      ),
    );
  }
}
