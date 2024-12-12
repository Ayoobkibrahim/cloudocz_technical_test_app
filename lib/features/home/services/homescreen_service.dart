import 'dart:convert';
import 'dart:developer';
import 'package:cloudocz_technical_test_app/data/local_storage.dart';
import 'package:cloudocz_technical_test_app/features/home/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String baseUrl = "https://erpbeta.cloudocz.com/api/app/tasks";
  final LocalStorageService _localStorageService = LocalStorageService();

  /// Fetch All Tasks
  Future<List<TaskData>> fetchTasks() async {
    try {
      final token = await _localStorageService.getToken();
      if (token == null) throw Exception("No token found");

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        return data.map((task) => TaskData.fromJson(task)).toList();
      } else {
        throw Exception('Failed to fetch tasks: ${response.body}');
      }
    } catch (e) {
      log("Exception in fetchTasks: $e");
      throw Exception(e.toString());
    }
  }

  /// Create a Task
  Future<bool?> createTask(TaskData task) async {
    try {
      final token = await _localStorageService.getToken();
      if (token == null) throw Exception("No token found");
      final response = await http.post(
        Uri.parse('$baseUrl/store'),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(task.toJson()),
      );

      log("Create Task Response: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to create task: ${response.body}');
      }
    } catch (e) {
      log("Exception in createTask: $e");
      throw Exception(e.toString());
    }
  }

  /// Update a Task
  Future<bool?> updateTask(TaskData task, int id) async {
    try {
      final token = await _localStorageService.getToken();
      if (token == null) throw Exception("No token found");
      final response = await http.post(
        Uri.parse('$baseUrl/update/$id'),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(task.toJson()),
      );

      log("Update Task Response: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log("Exception in updateTask: $e");
      throw Exception(e.toString());
    }
    return null;
  }

  /// Delete a Task
  Future<bool?> deleteTask(int id) async {
    final token = await _localStorageService.getToken();
    if (token == null) throw Exception("No token found");
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/destroy/$id'),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      log("Delete Task Response: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log("Exception in deleteTask: $e");
      throw Exception(e.toString());
    }
    return null;
  }
}
