import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mainScreen.dart';
import 'sign_up_screen.dart';
import '../controllers/authController.dart';

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
      Get.offAll(() => const MainScreen());
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
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                width: 150,
                child: Text(
                  "Log In",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                style: const TextStyle(color: Colors.blueAccent, fontSize: 24),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onChanged: (email) {
                  loginController.setEmail = email;
                },
              ),
              TextField(
                style: const TextStyle(color: Colors.blueAccent, fontSize: 24),
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
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
                    const Text(
                      "Dont have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const SignupScreen());
                      },
                      child: const Text(
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
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: login,
                          child: const Text("Login"),
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
