import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/authController.dart';
import 'mainScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthController signupController = Get.put(AuthController());
  bool isLoading = false;

  void signup() async {
    setState(() {
      isLoading = true;
    });
    String result = await signupController.signup;
    // print(result);
    setState(() {
      isLoading = false;
    });
    if (result == "success") {
      Get.offAll(() => const MainScreen());
    }
    AdvanceSnackBar(message: result).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blueAccent,
      // ),
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
                  "Sign up NOW",
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
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                onChanged: (email) {
                  signupController.setEmail = email;
                },
              ),
              TextField(
                style: const TextStyle(color: Colors.blueAccent, fontSize: 24),
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                onChanged: (password) {
                  signupController.setPassword = password;
                },
              ),
              TextFormField(
                style: const TextStyle(color: Colors.blueAccent, fontSize: 24),
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                onChanged: (confirmPassword) {
                  signupController.setConfirmPassword = confirmPassword;
                },
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ElevatedButton(
                                onPressed: signup,
                                child: const Text("Submit"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("Cancel"),
                              ),
                            ),
                          ],
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
