import 'package:equatable/equatable.dart';
import '../../domain/entities/todo.dart';

class TodoDetailModel extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const TodoDetailModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoDetailModel.fromJson(Map<String, dynamic> json) {
    return TodoDetailModel(
      id: json['id'] as int,
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'todo': todo, 'completed': completed, 'userId': userId};
  }

  TodoEntity toEntity() {
    return TodoEntity(
      todos: [Todo(id: id, todo: todo, completed: completed, userId: userId)],
      total: 1,
      skip: 0,
      limit: 1,
    );
  }

  @override
  List<Object?> get props => [id, todo, completed, userId];
}
