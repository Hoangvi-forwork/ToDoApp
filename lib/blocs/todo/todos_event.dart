part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodosEvent {
  final List<Todo> todos;

  const LoadTodosEvent({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

class AddTodoEvent extends TodosEvent {
  final Todo todo;

  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends TodosEvent {
  final Todo todo;

  const UpdateTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodosEvent {
  final Todo todo;

  const DeleteTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
