import 'package:equatable/equatable.dart';
import '../../domain/entities/todo.dart';

class TodoItemModel extends Equatable {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  const TodoItemModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoItemModel.fromJson(Map<String, dynamic> json) {
    return TodoItemModel(
      id: json['id'] as int,
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
      userId: json['userId'] as int,
    );
  }

  factory TodoItemModel.fromEntity(Todo todo) {
    return TodoItemModel(
      id: todo.id,
      todo: todo.todo,
      completed: todo.completed,
      userId: todo.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'todo': todo, 'completed': completed, 'userId': userId};
  }

  Todo toEntity() {
    return Todo(id: id, todo: todo, completed: completed, userId: userId);
  }

  @override
  List<Object?> get props => [id, todo, completed, userId];
}

class TodoModel extends Equatable {
  final List<TodoItemModel> todos;
  final num total;
  final num skip;
  final num limit;

  const TodoModel({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      todos: List<TodoItemModel>.from(
        json['todos'].map((e) => TodoItemModel.fromJson(e)),
      ),
      total: json['total'] as num,
      skip: json['skip'] as num,
      limit: json['limit'] as num,
    );
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      todos: entity.todos.map((e) => TodoItemModel.fromEntity(e)).toList(),
      total: entity.total,
      skip: entity.skip,
      limit: entity.limit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((e) => e.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }

  TodoEntity toEntity() {
    return TodoEntity(
      todos: todos.map((e) => e.toEntity()).toList(),
      total: total,
      skip: skip,
      limit: limit,
    );
  }

  @override
  List<Object?> get props => [todos, total, skip, limit];
}
