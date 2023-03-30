// ignore_for_file: prefer_const_constructors, annotate_overrides, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task.dart';
import '../tasks/task_manager.dart';

class EditTaskModal extends StatefulWidget {
  EditTaskModal({Key? key, required this.task, required this.refreshTask})
      : super(key: key);
  final Task task;
  Function refreshTask;
  @override
  State<EditTaskModal> createState() => _EditTaskModalState();
}

class _EditTaskModalState extends State<EditTaskModal> {
  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  DateTime? selectedDate;
  bool _isChecked = false;
  @override
  void dispose() {
    taskNameController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    taskNameController.text = widget.task.taskName;
    descriptionController.text = widget.task.description;
    selectedDate = widget.task.duedate;
    dueDateController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
    _isChecked = widget.task.isImportant;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: taskNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                // labelText: taskNow?.description,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    Text('Important'),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.calendar_month_sharp,
                    size: 35,
                    color: Color.fromARGB(255, 76, 76, 76),
                  ),
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                        dueDateController.text =
                            DateFormat('dd/MM/yyyy').format(selectedDate!);
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: dueDateController,
              decoration: InputDecoration(
                // labelText: DateFormat('dd/MM/yyyy').format(duedate!),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {},
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<TaskManager>().updateTask(
                          widget.task.taskId,
                          taskNameController.text,
                          descriptionController.text,
                          _isChecked,
                          dueDateController.text,
                        );
                    widget.refreshTask();
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
