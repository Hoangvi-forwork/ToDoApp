import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todos_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoading()) {
    on<LoadTodosEvent>(_onLoadToDos);
    on<AddTodoEvent>(_onAddToDo);
    on<UpdateTodoEvent>(_onUpdateToDo);
    on<DeleteTodoEvent>(_onDeleteToDo);
  }
  void _onLoadToDos(LoadTodosEvent event, Emitter<TodosState> emit) {
    emit(
      TodosLoaded(todos: event.todos),
    );
  }

  void _onAddToDo(AddTodoEvent event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      emit(
        TodosLoaded(
          todos: List.from(state.todos)..add(event.todo),
        ),
      );
    }
  }

  void _onUpdateToDo(UpdateTodoEvent event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = (state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      })).toList();
      emit(TodosLoaded(todos: todos));
    }
  }

  void _onDeleteToDo(DeleteTodoEvent event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        return todo.id != event.todo.id;
      }).toList();
      emit(TodosLoaded(todos: todos));
    }
  }
}
