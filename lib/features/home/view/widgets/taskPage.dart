import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudocz_technical_test_app/features/home/view_model/homescreen_view_model.dart';

class Taskpage extends StatelessWidget {
  Taskpage({
    super.key,
    required this.name,
    required this.desc,
    required this.status,
    required this.percentage,
    required this.id,
  });

  final String name;
  final String desc;
  final String status;
  final int percentage;
  final int id;

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    final deleteLoading = context.watch<HomescreenViewModel>().deleteLoading;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Center(
        child: Text(
          "Task Details",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SizedBox(
        width: scrWidth * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(
              icon: Icons.assignment,
              label: "Task Name",
              value: name,
            ),
            const SizedBox(height: 15),
            _infoRow(
              icon: Icons.description_outlined,
              label: "Description",
              value: desc,
            ),
            const SizedBox(height: 15),
            _infoRow(
              icon: Icons.flag_outlined,
              label: "Status",
              value: status.toUpperCase(),
              valueStyle: TextStyle(
                color: status == "incomplete" ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _infoRow(
              icon: Icons.percent,
              label: "Completion",
              value: "$percentage%",
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Edit Button
            TextButton.icon(
              onPressed: () {
                _showEditBottomSheet(context);
              },
              icon: const Icon(Icons.edit, color: Colors.blue),
              label: const Text(
                "Edit",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Delete Button
            deleteLoading
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.red,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Deleting...",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      context
                          .read<HomescreenViewModel>()
                          .deleteTask(id, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ],
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    final homescreenViewModel =
        Provider.of<HomescreenViewModel>(context, listen: false);

    homescreenViewModel.taskControllerManager.setControllers(
      name: name,
      description: desc,
      status: status,
      percentage: percentage,
      deadline: '', // Initialize the deadline field if needed
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const Text(
                      "Edit Task",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Task Details Card
                    Card(
                      elevation: 2,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: homescreenViewModel
                                  .taskControllerManager.nameController,
                              decoration: InputDecoration(
                                labelText: "Task Name",
                                prefixIcon: const Icon(Icons.task),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a task name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: homescreenViewModel
                                  .taskControllerManager.descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: "Description",
                                prefixIcon: const Icon(Icons.description),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a description";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Task Progress & Deadline Card
                    Card(
                      elevation: 2,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: homescreenViewModel
                                  .taskControllerManager.statusController,
                              decoration: InputDecoration(
                                labelText: "Status",
                                prefixIcon: const Icon(Icons.timeline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a status";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: homescreenViewModel
                                  .taskControllerManager.percentageController,
                              decoration: InputDecoration(
                                labelText: "Percentage",
                                prefixIcon: const Icon(Icons.percent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a percentage";
                                }
                                final percentage = int.tryParse(value);
                                if (percentage == null ||
                                    percentage < 0 ||
                                    percentage > 100) {
                                  return "Please enter a valid percentage (0-100)";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                );
                                if (selectedDate != null) {
                                  homescreenViewModel.taskControllerManager
                                          .deadlineController.text =
                                      selectedDate
                                          .toIso8601String()
                                          .split('T')[0];
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: homescreenViewModel
                                      .taskControllerManager.deadlineController,
                                  decoration: InputDecoration(
                                    labelText: "Deadline",
                                    prefixIcon: const Icon(Icons.date_range),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Please select a deadline";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 80), // Space for buttons
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          homescreenViewModel.taskControllerManager
                              .clearControllers();
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.cancel_outlined,
                            color: Colors.red),
                        label: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            homescreenViewModel.updateTask(id, context);
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Save Task"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: valueStyle ??
                    const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
