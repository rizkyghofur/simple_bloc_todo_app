import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/todo/detail_todo_usecase.dart';
import 'todo_detail_event.dart';
import 'todo_detail_state.dart';

class TodoDetailBloc extends Bloc<TodoDetailEvent, TodoDetailState> {
  final DetailTodo _detailTodo;

  TodoDetailBloc({required DetailTodo detailTodo})
    : _detailTodo = detailTodo,
      super(const TodoDetailInitial()) {
    on<GetDetailTodoEvent>(_onGetDetailTodo);
  }

  Future<void> _onGetDetailTodo(
    GetDetailTodoEvent event,
    Emitter<TodoDetailState> emit,
  ) async {
    emit(const TodoDetailLoading());

    final result = await _detailTodo(event.id);

    result.fold(
      (failure) => emit(TodoDetailError(failure.message)),
      (data) => emit(TodoDetailSuccess(data)),
    );
  }
}
