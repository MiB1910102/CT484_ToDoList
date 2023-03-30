import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import 'task_manager.dart';
import 'task_detail.dart'; // Import the task detail page

class TaskListItem extends StatelessWidget {
  TaskListItem(
    this.task, {
    super.key,
    required this.index,
  });
  final Task task;
  int index;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: 40,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: (index % 2 == 0)
              ? Color.fromARGB(255, 234, 234, 234)
              : Color.fromARGB(255, 190, 218, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
          child: GestureDetector(
            // Wrap the Text widget with GestureDetector
            onTap: () {
              Navigator.push(
                // Push a new page on the navigation stack
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetail(
                      task: task), // Pass the task data to the detail page
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.taskName,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 75, 75, 75),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0, right: 3, bottom: 0),
                  child: Row(children: [
                    importantTaskButton(context, task),
                    deleteTaskButton(context, task),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteTaskButton(BuildContext context, Task task) {
    return InkWell(
      child: IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: Color.fromARGB(255, 75, 75, 75),
        ),
        onPressed: () {
          context.read<TaskManager>().deleteTask(task.taskId);
        },
      ),
    );
  }

  Widget importantTaskButton(BuildContext context, Task task) {
    return InkWell(
      child: ValueListenableBuilder<bool>(
        valueListenable: task.isImportantListenable,
        builder: (context, isImportant, child) {
          return IconButton(
            icon: Icon(
              isImportant ? Icons.star : Icons.star_border,
              color: Color.fromARGB(255, 75, 75, 75),
            ),
            onPressed: () {
              task.isImportant = !isImportant;
            },
          );
        },
      ),
    );
  }
}
