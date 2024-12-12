import 'package:flutter/material.dart';

class TaskControllerManager {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController(text: "2025-01-01");

  void clearControllers() {
    nameController.clear();
    descriptionController.clear();
    statusController.clear();
    percentageController.clear();
    deadlineController.clear();
  }

  void setControllers({
    required String name,
    required String description,
    String? status,
    int? percentage,
    String? deadline,
  }) {
    nameController.text = name;
    descriptionController.text = description;
    statusController.text = status ?? '';
    percentageController.text = percentage?.toString() ?? '';
    deadlineController.text = deadline ?? '';
  }
}
