import 'package:equatable/equatable.dart';

abstract class TodoDetailEvent extends Equatable {
  const TodoDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetDetailTodoEvent extends TodoDetailEvent {
  final int id;

  const GetDetailTodoEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
