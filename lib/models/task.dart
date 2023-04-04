import 'package:flutter/foundation.dart';

class Task {
  late String? taskId;
  late String taskName;
  late String description;
  late String duedate;
  late ValueNotifier<bool> _isImportant;
  late ValueNotifier<bool> _isDone;

  Task({
    this.taskId,
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
    String? duedate,
    bool? isImportant,
    bool? isDone,
  }) {
    return Task(
      taskId: taskId ?? this.taskId,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      duedate: duedate ?? this.duedate,
      isImportant: isImportant ?? this.isImportant,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'taskName': taskName,
      'description': description,
      'duetime': duedate,
      'isImportant': isImportant,
      'isDone': isDone,
    };
  }

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      taskName: json['taskName'],
      description: json['description'],
      duedate: json['duetime'],
      isImportant: json['isImportant'],
      isDone: json['isDone'],
    );
  }
}
