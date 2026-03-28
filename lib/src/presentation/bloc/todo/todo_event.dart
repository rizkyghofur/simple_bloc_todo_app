import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class GetTodoEvent extends TodoEvent {
  const GetTodoEvent();

  @override
  List<Object?> get props => [];
}

class SearchTodoEvent extends TodoEvent {
  final String query;

  const SearchTodoEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class LoadMoreTodoEvent extends TodoEvent {
  const LoadMoreTodoEvent();

  @override
  List<Object?> get props => [];
}
