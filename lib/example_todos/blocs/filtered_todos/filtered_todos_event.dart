import 'package:equatable/equatable.dart';
import 'package:learn_bloc/example_todos/models/todo.dart';
import 'package:learn_bloc/example_todos/models/visibility_filter.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();
}

class FilteredUpdated extends FilteredTodosEvent {
  final VisibilityFilter filter;

  const FilteredUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilteredUpdated { filter : $filter }';
}

class TodosUpdated extends FilteredTodosEvent {
  final List<Todo> todos;

  const TodosUpdated(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosUpdated { todos : $todos }';
}
