// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todolist/ui/tasks/task_list_widget.dart';
// import 'package:todolist/ui/tasks/task_manager.dart';

// import '../shared/add_task_modal.dart';
// import '../shared/info_drawer.dart';

// class TaskScreen extends StatefulWidget {
//   const TaskScreen({super.key});
//   @override
//   State<TaskScreen> createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   int _selectedIndex = 0;
//   var _showImportantTask = false;
//   var _showDonetTask = false;
//   var _showRunningTask = false;
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   bool isChecked = false;
//   late Future<void> _tasks;
//   @override
//   void initState() {
//     super.initState();
//     _tasks = context.read<TaskManager>().fetchTasks();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       key: _scaffoldKey,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.account_circle,
//             size: 35,
//           ),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//         title: const Text(
//           'TodoList',
//           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.add,
//               size: 34,
//             ),
//             onPressed: () {
//               showModalBottomSheet(
//                 isScrollControlled: true,
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AddTaskModal();
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       drawer: const InfoDrawer(),
//       body: Consumer<TaskManager>(
//         builder: (context, taskManager, child) {
//           return TaskList(_showImportantTask, _showDonetTask, _showRunningTask);
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue, // Màu của icon và label khi được chọn
//         unselectedItemColor: Colors.grey,
//         // Màu của icon và label khi không được chọn
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//             if (_selectedIndex == 0) {
//               _showImportantTask = false;
//               _showDonetTask = false;
//               _showRunningTask = false;
//             } else if (_selectedIndex == 1) {
//               _showImportantTask = false;
//               _showDonetTask = false;
//               _showRunningTask = true;
//             } else if (_selectedIndex == 2) {
//               _showImportantTask = true;
//               _showDonetTask = false;
//               _showRunningTask = false;
//             } else if (_selectedIndex == 3) {
//               _showImportantTask = false;
//               _showDonetTask = true;
//               _showRunningTask = false;
//             }
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//               size: 30,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.directions_run,
//               size: 30,
//             ),
//             label: 'Running',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.warning_amber,
//               size: 30,
//             ),
//             label: 'Important',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.done_all,
//               size: 30,
//             ),
//             label: 'Done',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/ui/tasks/task_list_widget.dart';
import 'package:todolist/ui/tasks/task_manager.dart';

import '../shared/add_task_modal.dart';
import '../shared/info_drawer.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int _selectedIndex = 0;
  var _showImportantTask = false;
  var _showDonetTask = false;
  var _showRunningTask = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isChecked = false;
  final _showRunning = ValueNotifier<bool>(false);
  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<TaskManager>().fetchTasks(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.account_circle,
            size: 35,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          'TodoList',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 34,
            ),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AddTaskModal();
                },
              );
            },
          ),
        ],
      ),
      drawer: const InfoDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child:
                TaskList(_showImportantTask, _showDonetTask, _showRunningTask),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Màu của icon và label khi được chọn
        unselectedItemColor: Colors.grey,
        // Màu của icon và label khi không được chọn
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              _showImportantTask = false;
              _showDonetTask = false;
              _showRunningTask = false;
            } else if (_selectedIndex == 1) {
              _showImportantTask = false;
              _showDonetTask = false;
              _showRunningTask = true;
            } else if (_selectedIndex == 2) {
              _showImportantTask = true;
              _showDonetTask = false;
              _showRunningTask = false;
            } else if (_selectedIndex == 3) {
              _showImportantTask = false;
              _showDonetTask = true;
              _showRunningTask = false;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_run,
              size: 30,
            ),
            label: 'Running',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.warning_amber,
              size: 30,
            ),
            label: 'Important',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done_all,
              size: 30,
            ),
            label: 'Done',
          ),
        ],
      ),
    );
  }
}
