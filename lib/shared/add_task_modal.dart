// ignore_for_file: prefer_const_constructors, annotate_overrides

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../tasks/task_manager.dart';

class AddTaskModal extends StatefulWidget {
  AddTaskModal({
    super.key,
  });
  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  String? _taskNameError;
  String? _taskDesError;
  String? _taskDueError;
  DateTime? selectedDate;
  bool isChecked = false;
  void dispose() {
    taskNameController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.dispose();
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
                labelText: 'Your task',
              ),
              onChanged: (value) {
                setState(() {
                  // Reset the error message when the user starts typing again
                  _taskNameError = null;
                });
              },
            ),
            if (_taskNameError != null)
              Text(
                _taskNameError!,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  // Reset the error message when the user starts typing again
                  _taskDesError = null;
                });
              },
            ),
            if (_taskDesError != null)
              Text(
                _taskDesError!,
                style: TextStyle(
                  color: Colors.red,
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
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
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
                labelText: 'Due date',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  // Reset the error message when the user starts typing again
                  _taskDueError = null;
                });
              },
              readOnly: true,
            ),
            if (_taskDueError != null)
              Text(
                _taskDueError!,
                style: TextStyle(
                  color: Colors.red,
                ),
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
                    taskNameController.text.isEmpty
                        ? setState(() {
                            _taskNameError = 'Please enter a task Name';
                          })
                        : descriptionController.text.isEmpty
                            ? setState(() {
                                _taskDesError =
                                    'Please enter a task Description';
                              })
                            : dueDateController.text.isEmpty
                                ? setState(() {
                                    _taskDueError =
                                        'Please enter a task Due Date';
                                  })
                                :
                                // Task name is not empty, add the task to the list
                                setState(() {
                                    context.read<TaskManager>().addTask(
                                          taskNameController.text,
                                          descriptionController.text,
                                          isChecked,
                                          dueDateController.text,
                                        );
                                    Navigator.pop(context);
                                  });
                    print(isChecked);
                  },
                  child: Text('Add'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
