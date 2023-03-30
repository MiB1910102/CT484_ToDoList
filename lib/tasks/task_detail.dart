// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

import 'task_manager.dart'; // import package intl

class TaskDetail extends StatelessWidget {
  final Task task;

  const TaskDetail({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Details',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.taskName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            const Divider(
              color: Colors.black,
            ),
            Text(
              'Description: ${task.description}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            const Divider(),
            Text(
              'Priority: ${task.isImportant ? "High" : "Low"}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            const Divider(),
            Text(
              'Due Date: ${DateFormat('dd/MM/yyyy').format(task.duedate)}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            const Divider(),
            Text(
              'Completed: ${task.isDone ? "Done" : "Running"}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: !task.isDone
          ? FloatingActionButton(
              onPressed: task.isDone
                  ? null
                  : () {
                      TaskManager().updateTaskStatus(task.taskId);
                      Navigator.pop(context);
                    },
              // ignore: sort_child_properties_last
              child: ValueListenableBuilder<bool>(
                valueListenable: task.isDoneListenable,
                builder: (context, isDone, child) {
                  return IconButton(
                    icon: Icon(
                      Icons.check,
                    ),
                    onPressed: () {
                      task.isDone = true;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              backgroundColor: Colors.blue,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
