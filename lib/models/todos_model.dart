// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String descriptions;
  bool? isCompleted;
  bool? isCancelled;

  Todo({
    required this.id,
    required this.task,
    required this.descriptions,
    this.isCompleted,
    this.isCancelled,
  }) {
    isCompleted = isCompleted ?? false;
    isCancelled = isCancelled ?? false;
  }

  Todo copyWith({
    String? id,
    String? task,
    String? descriptions,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      descriptions: descriptions ?? this.descriptions,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        descriptions,
        isCompleted,
        isCancelled,
      ];

  // static List<Todo> todos = [];
}
