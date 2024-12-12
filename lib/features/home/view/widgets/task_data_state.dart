import 'package:cloudocz_technical_test_app/config/components/bouncing_button_widget.dart';
import 'package:cloudocz_technical_test_app/extensions/mediaquery_extension.dart';
import 'package:cloudocz_technical_test_app/features/home/model/task_model.dart';
import 'package:cloudocz_technical_test_app/features/home/view/widgets/taskPage.dart';
import 'package:cloudocz_technical_test_app/features/home/view_model/homescreen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskDataState extends StatelessWidget {
  const TaskDataState({
    super.key,
    required this.scrWidth,
    required this.scrHeight,
  });

  final double scrWidth;
  final double scrHeight;

  @override
  Widget build(BuildContext context) {
    return Selector<HomescreenViewModel, List<TaskData>>(
      selector: (p0, p1) => p1.taskList,
      builder: (context, value, child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final task = value.elementAt(index);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
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
                  child: BouncingButtonWidget(
                    child: Container(
                      // height: scrHeight * 0.1,
                      width: scrWidth * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color.fromARGB(255, 207, 204, 204)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: scrWidth * 0.55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.name,
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontSize: scrHeight * 0.018,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  Text(task.description,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: scrHeight * 0.013,
                                              fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(task.status.toUpperCase(),
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(
                                            color: task.status == "incomplete"
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: scrHeight * 0.013,
                                            fontWeight: FontWeight.w400)),
                                Text("${task.percentage.toString()}%"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: scrHeight * 0.01,
                ),
            itemCount: value.length);
      },
    );
  }
}
