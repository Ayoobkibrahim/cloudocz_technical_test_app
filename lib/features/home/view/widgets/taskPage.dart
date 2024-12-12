import 'package:cloudocz_technical_test_app/config/components/bouncing_button_widget.dart';
import 'package:cloudocz_technical_test_app/extensions/mediaquery_extension.dart';
import 'package:cloudocz_technical_test_app/features/home/model/task_model.dart';
import 'package:cloudocz_technical_test_app/features/home/view_model/homescreen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    double scrWidth = context.mediaQueryWidth;
    double scrHeight = context.mediaQueryHeight;
    return AlertDialog(
      content: SizedBox(
        height: scrHeight * 0.4,
        width: scrWidth * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name),
            Text(desc),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Status: "),
                Text(
                  status.toUpperCase(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: status == "incomplete" ? Colors.red : Colors.green,
                  ),
                ),
                SizedBox(width: scrWidth * 0.03),
                Text('$percentage%'),
              ],
            ),
            _bottomButtons(scrHeight, scrWidth, context),
          ],
        ),
      ),
    );
  }

  Row _bottomButtons(double scrHeight, double scrWidth, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog
            _showTaskEditBottomSheet(context);
          },
          child: Container(
            height: scrHeight * 0.045,
            width: scrWidth * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Edit  ",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const Icon(
                    Icons.edit,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
        BouncingButtonWidget(
          child: GestureDetector(
            onTap: () {
              context.read<HomescreenViewModel>().deleteTask(id, context);
            },
            child: Container(
              height: scrHeight * 0.045,
              width: scrWidth * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  "Delete",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Displays a BottomSheet for updating the task
  void _showTaskEditBottomSheet(BuildContext context) {
    final homescreenViewModel =
        Provider.of<HomescreenViewModel>(context, listen: false);

    homescreenViewModel.taskControllerManager.setControllers(
      name: name,
      description: desc,
      status: status,
      percentage: percentage,
      deadline: '', // Pass deadline if available
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
            key: _formKey, // Attach the form key
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Update Task",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller:
                      homescreenViewModel.taskControllerManager.nameController,
                  decoration: const InputDecoration(
                    labelText: "Task Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Task Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: homescreenViewModel
                      .taskControllerManager.descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller:
                      homescreenViewModel.taskControllerManager.statusController,
                  decoration: const InputDecoration(
                    labelText: "Status",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: homescreenViewModel
                      .taskControllerManager.percentageController,
                  decoration: const InputDecoration(
                    labelText: "Percentage",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      homescreenViewModel
                          .taskControllerManager.deadlineController.text =
                          selectedDate.toIso8601String().split('T')[0];
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: homescreenViewModel
                          .taskControllerManager.deadlineController,
                      decoration: const InputDecoration(
                        labelText: "Deadline (Select Date)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deadline is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        homescreenViewModel.taskControllerManager.clearControllers();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          homescreenViewModel.updateTask(id, context);
                        }
                      },
                      child: const Text("Update"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
