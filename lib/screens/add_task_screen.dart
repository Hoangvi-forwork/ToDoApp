import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/todo/todos_bloc.dart';

import '../models/todos_model.dart';

class AddTodoScreen extends StatelessWidget {
  static const routeName = '/addTodoScreen';
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController taskController = TextEditingController();
    TextEditingController desController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Task"),
        centerTitle: true,
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'To Do Added!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Color.fromARGB(255, 24, 131, 28),
              ),
            );
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _inputTextFromField('Task ID:', idController),
                _inputTextFromField('Task:', taskController),
                _inputTextFromField('Description:', desController),
                // Add Button
                ElevatedButton(
                  onPressed: () {
                    var todo = Todo(
                      id: idController.value.text,
                      task: taskController.value.text,
                      descriptions: desController.value.text,
                    );
                    context.read<TodosBloc>().add(
                          AddTodoEvent(todo: todo),
                        );
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text("Add Todo"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Function
Column _inputTextFromField(
  String field,
  TextEditingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$field',
      ),
      Container(
        height: 56,
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        child: TextFormField(
          controller: controller,
        ),
      )
    ],
  );
}
