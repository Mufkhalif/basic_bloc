import 'package:equatable/equatable.dart';
import 'package:learn_bloc/example_todos/models/todo.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoadInProgress extends TodosState {}

class TodosLoadSuccesss extends TodosState {
  final List<Todo> todos;

  const TodosLoadSuccesss([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosloadSuccess: {todos: $todos} ';
}

class TodosLoadFailure extends TodosState {}
