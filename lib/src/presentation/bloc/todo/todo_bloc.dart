import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/todo.dart';
import '../../../data/models/todo_model.dart';
import '../../../domain/usecase/todo/get_todo_usecase.dart';
import '../../../domain/usecase/todo/search_todo_usecase.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodo _getTodo;
  final SearchTodo _searchTodo;

  TodoEntity? _cachedFullData;

  TodoBloc({required GetTodo getTodo, required SearchTodo searchTodo})
    : _getTodo = getTodo,
      _searchTodo = searchTodo,
      super(const TodoInitial()) {
    on<GetTodoEvent>(_onGetTodo);
    on<SearchTodoEvent>(_onSearchTodo);
    on<LoadMoreTodoEvent>(_onLoadMoreTodo);
  }

  Future<void> _onGetTodo(GetTodoEvent event, Emitter<TodoState> emit) async {
    emit(const TodoLoading());

    final result = await _getTodo.execute(limit: 10, skip: 0);

    result.fold((failure) => emit(TodoError(failure.message)), (data) {
      _cachedFullData = data;
      emit(
        TodoSuccess(
          data,
          originalData: data,
          isSearch: false,
          hasReachedMax: data.todos.length >= data.total,
        ),
      );
    });
  }

  Future<void> _onLoadMoreTodo(
    LoadMoreTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is! TodoSuccess ||
        currentState.hasReachedMax ||
        currentState.isLoadingMore ||
        currentState.isSearch) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final result = await _getTodo.execute(
      limit: 10,
      skip: currentState.data.todos.length,
    );

    result.fold((failure) => emit(TodoError(failure.message)), (data) {
      final newTodos = List<Todo>.from(currentState.data.todos)
        ..addAll(data.todos);

      final newStateData = TodoModel(
        todos: newTodos.map((e) => TodoItemModel.fromEntity(e)).toList(),
        total: data.total,
        skip: data.skip,
        limit: data.limit,
      ).toEntity();

      _cachedFullData = newStateData;
      emit(
        TodoSuccess(
          newStateData,
          originalData: newStateData,
          isSearch: false,
          hasReachedMax: newTodos.length >= data.total,
          isLoadingMore: false,
        ),
      );
    });
  }

  Future<void> _onSearchTodo(
    SearchTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    if (_cachedFullData == null) return;

    if (event.query.isEmpty) {
      emit(
        TodoSuccess(
          _cachedFullData!,
          originalData: _cachedFullData,
          isSearch: false,
          hasReachedMax:
              _cachedFullData!.todos.length >= _cachedFullData!.total,
        ),
      );
      return;
    }

    emit(const TodoLoading());

    final result = await _searchTodo(
      TodoModel.fromEntity(_cachedFullData!),
      event.query,
    );

    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (data) => emit(
        TodoSuccess(
          data,
          originalData: _cachedFullData,
          isSearch: true,
          hasReachedMax: true,
        ),
      ),
    );
  }
}
