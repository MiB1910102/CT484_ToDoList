import 'package:flutter/foundation.dart';

class Task {
  late String taskId;
  late String taskName;
  late String description;
  late DateTime duedate;
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

  Task copyWith({
    String? taskId,
    String? taskName,
    String? description,
    bool? isImportant,
    DateTime? duedate,
    bool? isDone,
  }) {
    return Task(
      taskId: taskId ?? this.taskId,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      isImportant: isImportant ?? this.isImportant,
      duedate: duedate ?? this.duedate,
      isDone: isDone ?? this.isDone,
    );
  }
}
