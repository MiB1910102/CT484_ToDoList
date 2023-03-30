import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task.dart';

import 'task_list_item.dart';
import 'task_manager.dart';

class TaskList extends StatefulWidget {
  final bool showImportant;
  final bool showDone;
  final bool showRunningTask;

  TaskList(this.showImportant, this.showDone, this.showRunningTask, {Key? key})
      : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  void refreshUi() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        final tasks = widget.showRunningTask
            ? taskManager.runningTask
            : widget.showImportant
                ? taskManager.importantTask
                : widget.showDone
                    ? taskManager.doneTask
                    : taskManager.tasks;

        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: tasks.length,
          itemBuilder: (context, index) =>
              TaskListItem(tasks[index], index: index, refreshUi: refreshUi),
        );
      },
    );
  }
}
