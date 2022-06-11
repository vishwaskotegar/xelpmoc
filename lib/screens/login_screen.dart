import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xelpcom/screens/mainScreen.dart';
import 'package:xelpcom/screens/sign_up_screen.dart';

import '../controllers/authController.dart';
import '../resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController loginController = Get.put(AuthController());
  bool _isLoading = false;

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String res = await loginController.login;

    setState(() {
      _isLoading = false;
    });

    if (res == "success") {
      // AdvanceSnackBar(message: "Logged In", isFixed: false).show(context);
      loginController.setEmail = "";
      loginController.setPassword = "";
      Get.to(() => const MainScreen());
    } else {
      AdvanceSnackBar(message: res, bgColor: Colors.red, isFixed: false)
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 150,
                child: Text(
                  "Log In",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                style: TextStyle(color: Colors.blueAccent, fontSize: 24),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onChanged: (email) {
                  loginController.setEmail = email;
                },
              ),
              TextField(
                style: TextStyle(color: Colors.blueAccent, fontSize: 24),
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onChanged: (password) {
                  loginController.setPassword = password;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SignupScreen());
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: login,
                          child: Text("Login"),
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
