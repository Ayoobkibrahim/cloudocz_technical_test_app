
import 'package:cloudocz_technical_test_app/features/authentication/view/login_screen.dart';
import 'package:cloudocz_technical_test_app/features/authentication/view/task_list_screen.dart';
import 'package:cloudocz_technical_test_app/features/authentication/view_model/login_view_model.dart';
import 'package:cloudocz_technical_test_app/features/home/view/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App with Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          '/homepage': (context) => Homescreen(),
        },
      ),
    );
  }
}
