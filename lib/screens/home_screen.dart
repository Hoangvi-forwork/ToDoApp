import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todos_app/models/todos_filter_model.dart';
import 'package:todos_app/screens/add_task_screen.dart';
import 'package:todos_app/widgets/todo_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 11, 4, 81),
            title: const Text('Todos'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTodoScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                ),
              ),
            ],
            bottom: TabBar(
              onTap: (tabIndex) {
                switch (tabIndex) {
                  case 0:
                    BlocProvider.of<TodoFilterBloc>(context).add(
                      const UpdateTodosEvent(
                        todosFilter: TodosFilter.pending,
                      ),
                    );
                    break;
                  case 1:
                    BlocProvider.of<TodoFilterBloc>(context).add(
                      const UpdateTodosEvent(
                        todosFilter: TodosFilter.cancelled,
                      ),
                    );
                }
              },
              tabs: const [
                Tab(
                  icon: Icon(Icons.pending),
                ),
                Tab(
                  icon: Icon(Icons.check),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _todos('Pending to do: '),
              _todos('Completed to do: '),
            ],
          )),
    );
  }

  BlocBuilder<TodoFilterBloc, TodoFilterState> _todos(String title) {
    return BlocBuilder<TodoFilterBloc, TodoFilterState>(
      builder: (context, state) {
        if (state is TodoFilterLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TodoFilterLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Text(title),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.filteredTodos.length,
                  itemBuilder: (context, index) {
                    return TodoCard(
                      todo: state.filteredTodos[index],
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Text('Someting went wrong');
        }
      },
    );
  }
}
