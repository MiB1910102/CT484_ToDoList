import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/services/auth_service.dart';

import '../models/auth_token.dart';
import '../models/task.dart';
import 'firebase_service.dart';

class TasksService extends FirebaseService {
  TasksService([AuthToken? authToken]) : super(authToken);
  AuthService authService = AuthService();
  Future<List<Task>> fetchTasks([bool filterByUser = false]) async {
    final List<Task> tasks = [];
    try {
      final token = await authService.getToken();
      final userid = await authService.getUserId();
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userid"' : '';
      final tasksUrl =
          Uri.parse('$databaseUrl/tasks.json?auth=$token&$filters');
      final response = await http.get(tasksUrl);
      final tasksMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(tasksMap['error']);
        return tasks;
      }
      tasksMap.forEach((taskId, task) {
        tasks.add(Task.fromJson({
          'taskId': taskId,
          ...task,
        }));
      });
      return tasks;
    } catch (error) {
      print(error);
      return tasks;
    }
  }

  Future<Task?> addTask(Task task) async {
    try {
      final token = await authService.getToken();
      final userid = await authService.getUserId();
      print('/add');
      print(token);
      print(userid);
      final url = Uri.parse('$databaseUrl/tasks.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          task.toJson()
            ..addAll({
              'creatorId': userid,
            }),
        ),
      );
      if (response.statusCode != 200) {
        print('error at here');
        throw Exception(json.decode(response.body)['error']);
      }
      return task.copyWith(
        taskId: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Future<Task?> addTask(Task task) async {
  //   try {
  //     final url = Uri.parse('$databaseUrl/Tasks.json?auth=$token');
  //     print(url);
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         task.toJson()
  //           ..addAll({
  //             'creatorId': userId,
  //           }),
  //       ),
  //     );
  //     if (response.statusCode != 200) {
  //       print('lỗi ở đây');
  //       throw Exception(json.decode(response.body)['error']);
  //     }
  //     // return Task.copyWith(
  //     //   id: json.decode(response.body)['name'],
  //     // );
  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }

  Future<bool> updateTask(Task Task) async {
    try {
      final token = await authService.getToken();
      final userid = await authService.getUserId();
      final url =
          Uri.parse('$databaseUrl/Tasks/${Task.taskId}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(Task.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      final token = await authService.getToken();
      final userid = await authService.getUserId();
      final url = Uri.parse('$databaseUrl/Tasks/$id.json?auth=$token');
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(Task Task) async {
    try {
      final token = await authService.getToken();
      final userid = await authService.getUserId();
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userid/${Task.taskId}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(
          Task.isImportant,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
