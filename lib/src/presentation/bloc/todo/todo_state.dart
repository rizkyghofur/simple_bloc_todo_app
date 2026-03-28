import 'package:equatable/equatable.dart';
import '../../../domain/entities/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {
  const TodoInitial();
}

class TodoLoading extends TodoState {
  const TodoLoading();
}

class TodoSuccess extends TodoState {
  final TodoEntity data;
  final TodoEntity? originalData;
  final bool isSearch;

  const TodoSuccess(this.data, {this.originalData, this.isSearch = false});

  @override
  List<Object?> get props => [data, originalData, isSearch];
}

class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object?> get props => [message];
}
