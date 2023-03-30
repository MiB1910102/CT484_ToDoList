// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

import '../shared/edit_task_modal.dart';
import 'task_manager.dart'; // import package intl

class TaskDetail extends StatefulWidget {
  final Task task;
  Function refresh;
  TaskDetail({
    Key? key,
    required this.task,
    required this.refresh,
  }) : super(key: key);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  void refreshTask() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.reply),
          onPressed: () {
            widget.refresh();
            Navigator.pop(context);
          },
        ),
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
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return EditTaskModal(
                      refreshTask: refreshTask, task: widget.task);
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.taskName,
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
              'Description: ${widget.task.description}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            const Divider(),
            Text(
              'Priority: ${widget.task.isImportant ? "High" : "Low"}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            const Divider(),
            Text(
              'Due Date: ${DateFormat('dd/MM/yyyy').format(widget.task.duedate)}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            const Divider(),
            Text(
              'Completed: ${widget.task.isDone ? "Done" : "Running"}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: !widget.task.isDone
          ? FloatingActionButton(
              onPressed: widget.task.isDone
                  ? null
                  : () {
                      TaskManager().updateTaskStatus(widget.task.taskId, true);
                      Navigator.pop(context);
                    },
              // ignore: sort_child_properties_last
              child: ValueListenableBuilder<bool>(
                valueListenable: widget.task.isDoneListenable,
                builder: (context, isDone, child) {
                  return IconButton(
                    icon: Icon(
                      Icons.check,
                    ),
                    onPressed: () {
                      widget.task.isDone = true;
                      setState(() {});
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
