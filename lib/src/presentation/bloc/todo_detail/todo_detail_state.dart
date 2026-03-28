import 'package:equatable/equatable.dart';
import '../../../domain/entities/todo.dart';

abstract class TodoDetailState extends Equatable {
  const TodoDetailState();

  @override
  List<Object?> get props => [];
}

class TodoDetailInitial extends TodoDetailState {
  const TodoDetailInitial();
}

class TodoDetailLoading extends TodoDetailState {
  const TodoDetailLoading();
}

class TodoDetailSuccess extends TodoDetailState {
  final TodoEntity data;

  const TodoDetailSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class TodoDetailError extends TodoDetailState {
  final String message;

  const TodoDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
