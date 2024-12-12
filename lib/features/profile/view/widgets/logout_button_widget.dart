import 'package:cloudocz_technical_test_app/config/components/bouncing_button_widget.dart';
import 'package:cloudocz_technical_test_app/extensions/mediaquery_extension.dart';
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
          context.read<LoginViewModel>().logout(context);
        },
        child: BouncingButtonWidget(
          child: Container(
            height: scrHeight * 0.07,
            width: scrWidth,
            decoration: BoxDecoration(
              color: Colors.amber,
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
}
