import 'package:flutter/foundation.dart';

class Task {
  final String taskId;
  final String taskName;
  final String description;
  final DateTime duedate;
  late ValueNotifier<bool> _isImportant;
  late ValueNotifier<bool> _isDone;

  Task({
    required this.taskId,
    required this.taskName,
    required this.description,
    required this.duedate,
    isImportant = false,
    isDone = false,
  })  : _isImportant = ValueNotifier(isImportant),
        _isDone = ValueNotifier(isDone);

  set isImportant(bool newValue) {
    _isImportant.value = newValue;
  }

  bool get isImportant {
    return _isImportant.value;
  }

  ValueNotifier<bool> get isImportantListenable {
    return _isImportant;
  }

  set isDone(bool newValue) {
    _isDone.value = newValue;
  }

  bool get isDone {
    return _isDone.value;
  }

  ValueNotifier<bool> get isDoneListenable {
    return _isDone;
  }
}
