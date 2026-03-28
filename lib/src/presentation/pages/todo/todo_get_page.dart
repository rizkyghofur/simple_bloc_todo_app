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

class TodoGetPage extends StatefulWidget {
  const TodoGetPage({super.key});

  @override
  State<TodoGetPage> createState() => _TodoGetPageState();
}

class _TodoGetPageState extends State<TodoGetPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      sl<TodoBloc>().add(const LoadMoreTodoEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

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
                        : RefreshIndicator.adaptive(
                            onRefresh: () async {
                              sl<TodoBloc>().add(const GetTodoEvent());
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: state.isLoadingMore
                                  ? todos.length + 1
                                  : todos.length,
                              itemBuilder: (context, index) {
                                if (index >= todos.length) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
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
