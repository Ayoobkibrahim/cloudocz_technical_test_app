// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloudocz_technical_test_app/features/home/model/task_model.dart';
import 'package:cloudocz_technical_test_app/features/home/services/homescreen_service.dart';
import 'package:cloudocz_technical_test_app/features/home/view_model/taskControllerManager.dart';
import 'package:flutter/material.dart';

class HomescreenViewModel extends ChangeNotifier {
  final TaskService taskService = TaskService();

  final TaskControllerManager taskControllerManager = TaskControllerManager();

  List<TaskData>? _taskList;
  List<TaskData>? get taskList => _taskList;

  bool _deleteLoading = false;

  bool get deleteLoading => _deleteLoading;

  Future<void> fetchTask() async {
    try {
      _taskList = null;
      final response = await taskService.fetchTasks();
      log(response.toString());
      _taskList = response;
    } catch (e) {
      _taskList = [];
    }
    notifyListeners();
  }

  void setLoading(bool val) {
    _deleteLoading = val;
    notifyListeners();
  }

  Future<void> deleteTask(int id, BuildContext context) async {
    setLoading(true);

    try {
      final response = await taskService.deleteTask(id);
      if (response == true) {
        Navigator.of(context).pop();
        setLoading(false);
        await fetchTask();
      }
    } catch (e) {
      setLoading(false);
    }

    log(_deleteLoading.toString());
    notifyListeners();
  }

  Future<void> createTask(BuildContext context) async {
    try {
      final taskName = taskControllerManager.nameController.text;
      final taskDescription = taskControllerManager.descriptionController.text;
      final taskStatus = taskControllerManager.statusController.text;
      final taskPercentage =
          int.tryParse(taskControllerManager.percentageController.text) ?? 0;
      final taskDeadline = taskControllerManager.deadlineController.text;

      if (taskName.isEmpty || taskDescription.isEmpty || taskDeadline.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Name, Description, and Deadline are required')),
        );
        return;
      }

      final task = TaskData(
        id: 0, 
        name: taskName,
        description: taskDescription,
        status: taskStatus,
        percentage: taskPercentage,
        deadline: taskDeadline,
      );

      final response = await taskService.createTask(task);

      if (response == true) {
        await fetchTask();
      }

      taskControllerManager.clearControllers();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task Created Successfully!')),
      );
    } catch (e) {
      log('Error creating task: $e');
    }
    notifyListeners();
  }

  Future<void> updateTask(int taskId, BuildContext context) async {
    try {
      final taskName = taskControllerManager.nameController.text;
      final taskDescription = taskControllerManager.descriptionController.text;
      final taskStatus = taskControllerManager.statusController.text;
      final taskPercentage =
          int.tryParse(taskControllerManager.percentageController.text) ?? 0;
      final taskDeadline = taskControllerManager.deadlineController.text;

      if (taskName.isEmpty || taskDescription.isEmpty || taskDeadline.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Name, Description, and Deadline are required')),
        );
        return;
      }

      final task = TaskData(
        id: taskId, 
        name: taskName,
        description: taskDescription,
        status: taskStatus,
        percentage: taskPercentage,
        deadline: taskDeadline,
      );

      final response = await taskService.updateTask(task, taskId);

      if (response == true) {
        await fetchTask();
      }

      taskControllerManager.clearControllers();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task Updated Successfully!')),
      );
    } catch (e) {
      log('Error updating task: $e');
    }
    notifyListeners();
  }

  void setTaskData(TaskData task) {
    taskControllerManager.setControllers(
      name: task.name,
      description: task.description,
      status: task.status,
      percentage: task.percentage,
      deadline: task.deadline,
    );
  }
}
