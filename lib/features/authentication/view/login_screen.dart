import 'package:cloudocz_technical_test_app/extensions/mediaquery_extension.dart';
import 'package:cloudocz_technical_test_app/features/authentication/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;
    double scrWidth = context.mediaQueryWidth;
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: context.textTheme.headlineLarge,
              ),
              (scrHeight * 0.1).height,
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username must not be empty";
                  }
                  return null;
                },
              ),
              (scrHeight * 0.016).height,
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password must not be empty";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters long";
                  }
                  return null;
                },
              ),
              (scrHeight * 0.016).height,
              if (loginViewModel.errorMessage != null)
                Text(
                  loginViewModel.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              (scrHeight * 0.016).height,
              loginViewModel.isLoading
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await loginViewModel.login(
                            usernameController.text.trim(),
                            passwordController.text.trim(),
                          );

                          if (success == true) {
                            Navigator.pushReplacementNamed(
                              context,
                              '/homepage',
                            );
                          }
                        }
                      },
                      child: Container(
                        width: scrWidth,
                        height: scrHeight * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
