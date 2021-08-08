import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/example_todos/blocs/filtered_todos/filtered_todos_event.dart';
import 'package:learn_bloc/example_todos/blocs/filtered_todos/filtered_todos_state.dart';
import 'package:learn_bloc/example_todos/blocs/todos/todos.dart';
import 'package:learn_bloc/example_todos/models/todo.dart';
import 'package:learn_bloc/example_todos/models/visibility_filter.dart';

// class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
//   final TodosBloc todosBloc;
//   StreamSubscription todosSubscription;

//   FilteredTodosBloc({required this.todosBloc})
//       : super(FilteredTodosLoadInProgress());

//   @override
//   Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
//     if (event is FilteredUpdated) {
//       yield* _mapFilterUpdatedToState(event);
//     } else if (event is TodosUpdated) {
//       yield* _mapTodosUpdatedToState(event);
//     }
//   }

//   Stream<FilteredTodosState> _mapFilterUpdatedToState(
//     FilteredUpdated event,
//   ) async* {
//     if (todosBloc.state is TodosLoadSuccesss) {
//       yield FilteredTodosLoadSuccess(
//         _mapTodosToFilteredTodos(
//           (todosBloc.state as TodosLoadSuccesss).todos,
//           event.filter,
//         ),
//         event.filter,
//       );
//     }
//   }

//   Stream<FilteredTodosState> _mapTodosUpdatedToState(
//     TodosUpdated event,
//   ) async* {
//     final visibilityFilter = state is FilteredTodosLoadSuccess
//         ? (state as FilteredTodosLoadSuccess).activeFilter
//         : VisibilityFilter.all;
//     yield FilteredTodosLoadSuccess(
//       _mapTodosToFilteredTodos(
//         (todosBloc.state as TodosLoadSuccesss).todos,
//         visibilityFilter,
//       ),
//       visibilityFilter,
//     );
//   }

//   List<Todo> _mapTodosToFilteredTodos(
//       List<Todo> todos, VisibilityFilter filter) {
//     return todos.where((todo) {
//       if (filter == VisibilityFilter.all) {
//         return true;
//       } else if (filter == VisibilityFilter.active) {
//         return !todo.complete;
//       } else {
//         return todo.complete;
//       }
//     }).toList();
//   }

//   @override
//   Future<void> close() {
//     todosSubscription.cancel();
//     return super.close();
//   }
// }
