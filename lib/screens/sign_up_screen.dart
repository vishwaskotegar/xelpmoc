import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:xelpcom/controllers/authController.dart';
import 'package:xelpcom/screens/mainScreen.dart';

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
      Get.offAll(() => MainScreen());
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
              SizedBox(
                height: 50,
              ),
              Container(
                width: 150,
                child: Text(
                  "Sign up NOW",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (email) {
                  signupController.setEmail = email;
                },
              ),
              TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (password) {
                  signupController.setPassword = password;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (confirmPassword) {
                  signupController.setConfirmPassword = confirmPassword;
                },
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: signup,
                          child: Text("Submit"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Cancel"),
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
