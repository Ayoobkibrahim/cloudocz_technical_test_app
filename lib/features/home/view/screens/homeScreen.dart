import 'package:cloudocz_technical_test_app/config/components/bouncing_button_widget.dart';
import 'package:cloudocz_technical_test_app/extensions/mediaquery_extension.dart';
import 'package:cloudocz_technical_test_app/features/authentication/model/user_model.dart';
import 'package:cloudocz_technical_test_app/features/authentication/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    double scrWidth = context.mediaQueryWidth;
    double scrHeight = context.mediaQueryHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text("TASK"),
        actions: [
          BouncingButtonWidget(
            child: GestureDetector(
              child: Row(
                children: [
                  Selector<LoginViewModel, UserModel?>(
                      selector: (p0, p1) => p1.userModel,
                      builder: (context, value, child) =>
                          Text(value?.name ?? "")),
                  (scrWidth * 0.02).width,
                  Selector<LoginViewModel, UserModel?>(
                    selector: (p0, p1) => p1.userModel,
                    builder: (context, value, child) => CircleAvatar(
                      backgroundImage: NetworkImage(value?.image ?? ""),
                    ),
                  ),
                  (scrWidth * 0.05).width,
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
