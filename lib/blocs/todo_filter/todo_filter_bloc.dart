import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/blocs/todo/todos_bloc.dart';

import '../../models/todos_filter_model.dart';
import '../../models/todos_model.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  final TodosBloc _todosBloc;
  late StreamSubscription _todoSubscription;
  TodoFilterBloc({required TodosBloc todosBloc})
      : _todosBloc = todosBloc,
        super(
          TodoFilterLoading(),
        ) {
    on<UpdateFilterEvent>(_onUpdateFilter);
    on<UpdateTodosEvent>(_onUpdateTodos);

    _todoSubscription = todosBloc.stream.listen((state) {
      add(
        const UpdateFilterEvent(),
      );
    });
  }
  void _onUpdateFilter(UpdateFilterEvent event, Emitter<TodoFilterState> emit) {
    if (state is TodoFilterLoading) {
      add(
        const UpdateTodosEvent(todosFilter: TodosFilter.pending),
      );
    }
    if (state is TodoFilterLoaded) {
      final state = this.state as TodoFilterLoaded;
      add(
        UpdateTodosEvent(
          todosFilter: state.todosFilter,
        ),
      );
    }
  }

  void _onUpdateTodos(UpdateTodosEvent event, Emitter<TodoFilterState> emit) {
    final state = _todosBloc.state;
    //! TodosLoaded definetion in todos_bloc.dart
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        switch (event.todosFilter) {
          case TodosFilter.all:
            return true;
          case TodosFilter.completed:
            return todo.isCompleted!;
          case TodosFilter.cancelled:
            return todo.isCancelled!;
          case TodosFilter.pending:
            return !(todo.isCompleted! || todo.isCancelled!);
        }
      }).toList();
      emit(
        TodoFilterLoaded(
          filteredTodos: todos,
        ),
      );
    }
  }
}
