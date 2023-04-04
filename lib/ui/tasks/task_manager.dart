// ignore_for_file: unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/services/tasks_service.dart';

import '../../models/auth_token.dart';

class TaskManager with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _tasks = [];

  final TasksService _tasksService;

  TaskManager([AuthToken? authToken]) : _tasksService = TasksService(authToken);

  set authToken(AuthToken? authToken) {
    _tasksService.authToken = authToken;
  }

  Future<void> fetchTasks([bool filterByUser = false]) async {
    _tasks = await _tasksService.fetchTasks(filterByUser);
    notifyListeners();
  }

  Future<void> addTask(String taskName, String description, bool important,
      String dueDate) async {
    Task task = Task(
        taskName: taskName,
        description: description,
        duedate: dueDate,
        isImportant: important,
        isDone: false);
    print('${task.taskId} ok');

    final newTask = await _tasksService.addTask(task);
    if (newTask != null) {
      print('Y');
    } else {
      print('Nnnnnnnnnnnnnnnn');
    }
    if (newTask != null) {
      _tasks.add(newTask);
      notifyListeners();
    }
  }

  // TaskManager() {
  //   _tasks.sort((a, b) => a.duedate.compareTo(b.duedate));
  //   notifyListeners();
  // }
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

  List<Task> get runningTask {
    return _tasks.where((task) => !task.isDone).toList();
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

  void updateTaskStatus(String id, bool doneStatus) {
    final task = _tasks.firstWhere((task) => task.taskId == id);
    task.isDone = doneStatus;
    notifyListeners();
  }

  // void addTask(
  //     String taskName, String description, bool important, String dueDate) {
  //   Task task = Task(
  //       taskId: '${DateTime.now().toIso8601String()}',
  //       taskName: taskName,
  //       description: description,
  //       isImportant: important,
  //       duedate: DateFormat('dd/MM/yyyy').parse(dueDate));
  //   _tasks.add(task);
  //   notifyListeners();
  // }

  void updateTask(String taskId, String taskName, String description,
      bool important, String dueDate) {
    Task task = _tasks.firstWhere((task) => task.taskId == taskId);
    task.taskName = taskName;
    task.description = description;
    task.isImportant = important;
    task.duedate = dueDate;
    notifyListeners();
  }
}
