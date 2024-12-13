import 'package:cloudocz_technical_test_app/config/components/bouncing_button_widget.dart';
import 'package:cloudocz_technical_test_app/config/extensions/mediaquery_extension.dart';
import 'package:cloudocz_technical_test_app/features/authentication/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    double scrWidth = context.mediaQueryWidth;

    return Padding(
      padding: const EdgeInsets.all(23),
      child: GestureDetector(
        onTap: () {
          _showLogoutConfirmationDialog(context);
        },
        child: BouncingButtonWidget(
          child: Container(
            height: scrHeight * 0.07,
            width: scrWidth,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Logout",
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: scrHeight * 0.018,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            "Confirm Logout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            // Confirm Logout Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                context
                    .read<LoginViewModel>()
                    .logout(context); // Perform logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle:
                    context.textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
              child: Text(
                "Logout",
                style:
                    context.textTheme.bodySmall?.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
