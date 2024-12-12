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

    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }

  void _showTaskCreationBottomSheet(BuildContext context) {
    final homescreenViewModel =
        Provider.of<HomescreenViewModel>(context, listen: false);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create New Task",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller:
                    homescreenViewModel.taskControllerManager.nameController,
                decoration: const InputDecoration(
                  labelText: "Task Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: homescreenViewModel
                    .taskControllerManager.descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller:
                    homescreenViewModel.taskControllerManager.statusController,
                decoration: const InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
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
                    homescreenViewModel.taskControllerManager.deadlineController
                        .text = selectedDate.toIso8601String().split('T')[0];
                  }
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: homescreenViewModel
                        .taskControllerManager.deadlineController,
                    decoration: const InputDecoration(
                      labelText: "Deadline (Select Date)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      homescreenViewModel.taskControllerManager
                          .clearControllers();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      homescreenViewModel.createTask(context);
                    },
                    child: const Text("Create"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
