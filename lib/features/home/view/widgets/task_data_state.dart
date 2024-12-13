import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudocz_technical_test_app/features/home/model/task_model.dart';
import 'package:cloudocz_technical_test_app/features/home/view/widgets/taskPage.dart';
import 'package:cloudocz_technical_test_app/features/home/view_model/homescreen_view_model.dart';

class TaskDataState extends StatelessWidget {
  const TaskDataState({super.key});

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;

    return Selector<HomescreenViewModel, List<TaskData>?>(
      selector: (context, viewModel) => viewModel.taskList,
      builder: (context, value, child) {
        if (value == null) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Please wait..."),
              ],
            ),
          );
        }

        if (value.isEmpty) {
          return Center(
            child: Text(
              "No Value Found",
              style: TextStyle(
                fontSize: scrHeight * 0.02,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemBuilder: (context, index) {
            final task = value.elementAt(index);
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Taskpage(
                    name: task.name,
                    desc: task.description,
                    status: task.status,
                    percentage: task.percentage,
                    id: task.id,
                  ),
                );
              },
              child: Container(
                width: scrWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      task.status == "incomplete"
                          ? Colors.red.withOpacity(0.2)
                          : Colors.green.withOpacity(0.2),
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              task.name,
                              style: TextStyle(
                                fontSize: scrHeight * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Task Status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: task.status == "incomplete"
                                  ? Colors.red.withOpacity(0.8)
                                  : Colors.green.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              task.status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Text(
                        task.description,
                        style: TextStyle(
                          fontSize: scrHeight * 0.016,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Task ID: ${task.id}",
                            style: TextStyle(
                              fontSize: scrHeight * 0.014,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${task.percentage}",
                                style: TextStyle(
                                  fontSize: scrHeight * 0.016,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Icon(
                                Icons.percent,
                                size: 16,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: scrHeight * 0.02,
          ),
          itemCount: value.length,
        );
      },
    );
  }
}
