import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/todo/todos_bloc.dart';
import 'package:todos_app/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todos_app/screens/home_screen.dart';

import 'models/todos_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              LoadTodosEvent(
                todos: [
                  Todo(
                      id: '1',
                      task: 'Task 01',
                      descriptions: 'Descriptions task 01'),
                  Todo(
                      id: '2',
                      task: 'Task 02',
                      descriptions: 'Descriptions task 02'),
                ],
              ),
            ),
        ),
        BlocProvider(
          create: (context) => TodoFilterBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
