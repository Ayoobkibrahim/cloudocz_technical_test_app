import 'package:cloudocz_technical_test_app/config/extensions/mediaquery_extension.dart';
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
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: scrHeight * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              tasks,
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: scrHeight * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Progress",
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: scrHeight * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "$percentage%",
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: scrHeight * 0.018,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
