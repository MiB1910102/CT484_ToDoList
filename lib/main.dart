import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/tasks/task_list_widget.dart';
import 'tasks/task_manager.dart';
import 'tasks/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => TaskManager()),
      ],
      child: MaterialApp(
        title: 'ToDoList',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: Colors.deepOrange,
          ),
        ),
        home: TaskScreen(),
      ),
    );
  }
}
