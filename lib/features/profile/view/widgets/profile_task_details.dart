import 'package:cloudocz_technical_test_app/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

class ProfileTaskDetails extends StatelessWidget {
  const ProfileTaskDetails({
    super.key,
    required this.tasks,
    required this.percentage,
  });

  final String tasks;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              "Tasks",
              style: TextStyle(
                fontSize: scrHeight * 0.018,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              tasks,
              style: TextStyle(
                fontSize: scrHeight * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Progress",
              style: TextStyle(
                fontSize: scrHeight * 0.018,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "$percentage%",
              style: TextStyle(
                fontSize: scrHeight * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
