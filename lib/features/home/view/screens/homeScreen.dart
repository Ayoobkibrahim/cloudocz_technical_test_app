import 'package:cloudocz_technical_test_app/features/home/view/widgets/home_app_bar_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudocz_technical_test_app/features/home/view/widgets/task_data_state.dart';
import 'package:cloudocz_technical_test_app/features/home/view_model/homescreen_view_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late HomescreenViewModel _homescreenViewModel;

  @override
  void initState() {
    _homescreenViewModel = context.read<HomescreenViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homescreenViewModel.fetchTask();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
        actions: const [
          HomeAppBarAction(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskCreationBottomSheet(context);
        },
        tooltip: "Add Task",
        child: const Icon(Icons.add),
      ),
      body: const TaskDataState(),
    );
  }



  void _showTaskCreationBottomSheet(BuildContext context) {
  final homescreenViewModel =
      Provider.of<HomescreenViewModel>(context, listen: false);

  final formKey = GlobalKey<FormState>();

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
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    "Create New Task",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                                    .deadlineController.text = selectedDate
                                    .toIso8601String()
                                    .split('T')[0];
                              }
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: homescreenViewModel
                                    .taskControllerManager.deadlineController,
                                decoration: InputDecoration(
                                  labelText: "Deadline (Select Date)",
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
                  const SizedBox(height: 80), 
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
                      icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                      label: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          homescreenViewModel.createTask(context);
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Create Task"),
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

}
