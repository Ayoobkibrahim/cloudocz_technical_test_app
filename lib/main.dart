import 'package:cloudocz_technical_test_app/features/authentication/view/login_screen.dart';
import 'package:cloudocz_technical_test_app/features/authentication/view_model/login_view_model.dart';
import 'package:cloudocz_technical_test_app/features/home/view/screens/homeScreen.dart';
import 'package:cloudocz_technical_test_app/features/home/view_model/homescreen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async initialization

  final loginViewModel = LoginViewModel();
  await loginViewModel.checkLoginStatus();

  runApp(MyApp(loginViewModel: loginViewModel));
}

class MyApp extends StatelessWidget {
  final LoginViewModel loginViewModel;

  MyApp({required this.loginViewModel});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: loginViewModel),
        ChangeNotifierProvider(create: (_) => HomescreenViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App with Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: loginViewModel.isLoggedIn ? Homescreen() : LoginScreen(),
        routes: {
          '/homepage': (context) => Homescreen(),
        },
      ),
    );
  }
}
