import 'dart:convert';
import 'dart:developer';
import 'package:cloudocz_technical_test_app/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String baseUrl = "https://erpbeta.cloudocz.com/api/app/tasks";

  /// Fetch All Tasks
  Future<List<Task>> fetchTasks(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      log("Fetch Tasks Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'] as List;
        return data.map((task) => Task.fromJson(task)).toList();
      } else {
        throw Exception('Failed to fetch tasks: ${response.body}');
      }
    } catch (e) {
      log("Exception in fetchTasks: $e");
      throw Exception(e.toString());
    }
  }

  /// Create a Task
  Future<Task> createTask(String token, Task task) async {
    try {
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
        final responseData = json.decode(response.body);
        return Task.fromJson(responseData['data']);
      } else {
        throw Exception('Failed to create task: ${response.body}');
      }
    } catch (e) {
      log("Exception in createTask: $e");
      throw Exception(e.toString());
    }
  }

  /// Update a Task
  Future<void> updateTask(String token, Task task, int id) async {
    try {
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

      if (response.statusCode != 200) {
        throw Exception('Failed to update task: ${response.body}');
      }
    } catch (e) {
      log("Exception in updateTask: $e");
      throw Exception(e.toString());
    }
  }

  /// Delete a Task
  Future<void> deleteTask(String token, int id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/destroy/$id'),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      log("Delete Task Response: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception('Failed to delete task: ${response.body}');
      }
    } catch (e) {
      log("Exception in deleteTask: $e");
      throw Exception(e.toString());
    }
  }
}
