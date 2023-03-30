// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/task.dart';

class TaskManager with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _tasks = [
    Task(
      taskId: '1',
      taskName: 'Buy milk',
      description: 'Đi mua sữa',
      duedate: DateTime.utc(2023, 2, 3),
      isImportant: true,
    ),
    Task(
        taskId: '2',
        taskName: 'Buy milk 1',
        description: 'Đi mua sữa',
        duedate: DateTime.utc(2023, 2, 1),
        isImportant: true,
        isDone: false),
    Task(
        taskId: '3',
        taskName: 'Buy milk 2',
        description: 'Đi mua sữa',
        duedate: DateTime.utc(2023, 2, 6),
        isImportant: false,
        isDone: true),
    Task(
        taskId: '4',
        taskName: 'Buy milk 3',
        description: 'Đi mua sữa',
        duedate: DateTime.utc(2023, 2, 9),
        isImportant: true,
        isDone: false),
    Task(
        taskId: '5',
        taskName: 'Buy milk 4',
        description: 'Đi mua sữa',
        duedate: DateTime.utc(2023, 2, 8),
        isImportant: true,
        isDone: true),
  ];
  TaskManager() {
    _tasks.sort((a, b) => a.duedate.compareTo(b.duedate));
    notifyListeners();
  }
  int get taskCount {
    return _tasks.length;
  }

  List<Task> get tasks {
    return [..._tasks];
  }

  List<Task> get importantTask {
    return _tasks.where((task) => task.isImportant && !task.isDone).toList();
  }

  List<Task> get doneTask {
    return _tasks.where((task) => task.isDone).toList();
  }

  Task? findById(String id) {
    try {
      return _tasks.firstWhere((item) => item.taskId == id);
    } catch (error) {
      return null;
    }
  }

  void deleteTask(String id) {
    final index = _tasks.indexWhere((task) => task.taskId == id);
    _tasks.removeAt(index);
    notifyListeners();
  }

  void updateTaskStatus(String id) {
    final task = _tasks.firstWhere((task) => task.taskId == id);
    task.isDone = true;
    notifyListeners();
  }

  // void addTask(
  //   String taskName,
  //   String description,
  //   bool isImportant,
  //   String dueDate,
  // ) {
  //   final newTask = Task(
  //     taskId: DateTime.now().toString(),
  //     taskName: taskName,
  //     description: description,
  //     duedate: DateFormat('dd/MM/yyyy').parse(dueDate),
  //     isImportant: isImportant,
  //   );
  //   _tasks.add(newTask);
  //   notifyListeners();
  // }
  void addTask(
      String taskName, String description, bool important, String dueDate) {
    Task task = Task(
        taskId: '${DateTime.now().toIso8601String()}',
        taskName: taskName,
        description: description,
        isImportant: important,
        duedate: DateFormat('dd/MM/yyyy').parse(dueDate));
    _tasks.add(task);
    notifyListeners();
  }
}
