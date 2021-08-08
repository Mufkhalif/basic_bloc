import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_todos/blocs/todos/todos_event.dart';
import 'package:learn_bloc/example_todos/blocs/todos/todos_state.dart';
import 'package:learn_bloc/example_todos/models/todo.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:todos_repository_simple/todos_repository_simple.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepositoryFlutter todosRepository;

  TodosBloc({
    required this.todosRepository,
  }) : super(TodosLoadInProgress());

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is TodosLoaded) {
      yield* _mapTodosLoadedToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodosState> _mapTodosLoadedToState() async* {
    try {
      final todos = await this.todosRepository.loadTodos();
      yield TodosLoadSuccesss(
        todos.map(Todo.fromEntity).toList(),
      );
    } catch (_) {
      yield TodosLoadFailure();
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }

  Stream<TodosState> _mapTodoAddedToState(TodoAdded event) async* {
    if (state is TodosLoadSuccesss) {
      final List<Todo> updatedTodos =
          List.from((state as TodosLoadSuccesss).todos)..add(event.todo);

      yield TodosLoadSuccesss(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodosLoadSuccesss) {
      final List<Todo> updatedTodos =
          (state as TodosLoadSuccesss).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();

      yield TodosLoadSuccesss(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoDeletedToState(TodoDeleted event) async* {
    if (state is TodosLoadSuccesss) {
      final List<Todo> updatedTodos = (state as TodosLoadSuccesss)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();

      yield TodosLoadSuccesss(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoadSuccesss) {
      final allComplete = (state as TodosLoadSuccesss)
          .todos
          .every((element) => element.complete);

      final List<Todo> updatedTodos = (state as TodosLoadSuccesss)
          .todos
          .map((e) => e.copyWith(complete: !allComplete))
          .toList();

      yield TodosLoadSuccesss(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoadSuccesss) {
      final List<Todo> updatedTodos = (state as TodosLoadSuccesss)
          .todos
          .where((element) => !element.complete)
          .toList();

      yield TodosLoadSuccesss(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }
}
