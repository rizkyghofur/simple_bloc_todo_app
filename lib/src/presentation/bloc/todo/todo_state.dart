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
  final bool hasReachedMax;
  final bool isLoadingMore;

  const TodoSuccess(
    this.data, {
    this.originalData,
    this.isSearch = false,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  TodoSuccess copyWith({
    TodoEntity? data,
    TodoEntity? originalData,
    bool? isSearch,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return TodoSuccess(
      data ?? this.data,
      originalData: originalData ?? this.originalData,
      isSearch: isSearch ?? this.isSearch,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    data,
    originalData,
    isSearch,
    hasReachedMax,
    isLoadingMore,
  ];
}

class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object?> get props => [message];
}
