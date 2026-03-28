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
  }

  Future<void> _onGetTodo(GetTodoEvent event, Emitter<TodoState> emit) async {
    emit(const TodoLoading());

    final result = await _getTodo();

    result.fold((failure) => emit(TodoError(failure.message)), (data) {
      _cachedFullData = data;
      emit(TodoSuccess(data, originalData: data, isSearch: false));
    });
  }

  Future<void> _onSearchTodo(
    SearchTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    if (_cachedFullData == null) return;

    emit(const TodoLoading());

    final result = await _searchTodo(
      TodoModel.fromEntity(_cachedFullData!),
      event.query,
    );

    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (data) => emit(
        TodoSuccess(data, originalData: _cachedFullData, isSearch: true),
      ),
    );
  }
}
