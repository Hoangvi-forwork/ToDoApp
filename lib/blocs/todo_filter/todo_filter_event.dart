part of 'todo_filter_bloc.dart';

abstract class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilterEvent extends TodoFilterEvent {
  const UpdateFilterEvent();
  @override
  List<Object> get props => [];
}

class UpdateTodosEvent extends TodoFilterEvent {
  final TodosFilter todosFilter;
  const UpdateTodosEvent({this.todosFilter = TodosFilter.all});

  @override
  List<Object> get props => [todosFilter];
}
