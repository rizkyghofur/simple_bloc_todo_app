import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, todo, completed, userId];
}

class TodoEntity extends Equatable {
  final List<Todo> todos;
  final num total;
  final num skip;
  final num limit;

  const TodoEntity({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [todos, total, skip, limit];
}
