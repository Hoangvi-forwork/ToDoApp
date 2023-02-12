import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/todo/todos_bloc.dart';
import '../models/todos_model.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("#${todo.id}: ${todo.task} "),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          UpdateTodoEvent(
                            todo: todo.copyWith(isCompleted: true),
                          ),
                        );
                  },
                  icon: const Icon(Icons.add_task),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(DeleteTodoEvent(todo: todo));
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
