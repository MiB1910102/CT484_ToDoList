import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task.dart';

import 'task_list_item.dart';
import 'task_manager.dart';

class TaskList extends StatelessWidget {
  final bool showImportant;
  final bool showDone;

  const TaskList(this.showImportant, this.showDone, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        final tasks = showImportant
            ? taskManager.importantTask
            : showDone
                ? taskManager.doneTask
                : taskManager.tasks;

        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: tasks.length,
          itemBuilder: (context, index) =>
              TaskListItem(tasks[index], index: index),
        );
      },
    );
  }
}
