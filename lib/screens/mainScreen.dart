// ignore: file_names
import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/authController.dart';
import '../controllers/mathController.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthController _authController = Get.put(AuthController());
  final MathController _mathController = Get.put(MathController());
  late TextEditingController textOneController;
  late TextEditingController textTwoController;
  late TextEditingController textThreeController;
  int currentStep = 0;
  bool _isLoading = false;
  Set<int> prime = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textOneController = TextEditingController();
    textTwoController = TextEditingController();
    textThreeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textOneController.dispose();
    textTwoController.dispose();
    textThreeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 24, left: 16),
                    child: Text(
                      "Check for \nPrime",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Theme(
                data: ThemeData(
                  brightness: Brightness.dark,
                ),
                child: Stepper(
                  physics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics()),
                  // elevation: 10,
                  onStepContinue: () => onStepContinue(context),
                  onStepCancel: () {
                    currentStep == 0
                        ? null
                        : setState(() {
                            currentStep -= 1;
                          });
                  },
                  currentStep: currentStep,
                  steps: [
                    Step(
                      title: const Text(
                        "Enter 1st number",
                      ),
                      content: TextField(
                        controller: textOneController,
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 24),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          // labelText: "Email",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onChanged: (value) {
                          _mathController.setValueOne = int.parse(value);
                        },
                      ),
                    ),
                    Step(
                      title: const Text(
                        "Enter 2nd number",
                      ),
                      content: TextField(
                        controller: textTwoController,
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 24),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          // labelText: "Email",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onChanged: (value) {
                          _mathController.setValueTwo = int.parse(value);
                        },
                      ),
                    ),
                    Step(
                      title: const Text(
                        "Enter 3rd number",
                      ),
                      content: TextField(
                        controller: textThreeController,
                        style: const TextStyle(
                            color: Colors.blueAccent, fontSize: 24),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          // labelText: "Email",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onChanged: (value) {
                          _mathController.setValueThree = int.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)),
                  width: double.maxFinite,
                  height: 200,
                  child: Column(children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "The Prime Numbers are :",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$prime",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 48),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () => signout(), child: const Text("log out!"))
            ],
          ),
        ),
      ),
    );
  }

  void onStepContinue(BuildContext context) {
    if (currentStep == 0) {
      if (textOneController.text.isEmpty) {
        const AdvanceSnackBar(message: "Enter value").show(context);
      } else {
        setState(() {
          currentStep += 1;
        });
        return;
      }
    }
    if (currentStep == 1) {
      if (textTwoController.text.isEmpty) {
        const AdvanceSnackBar(message: "Enter value").show(context);
      } else {
        setState(() {
          currentStep += 1;
        });
        return;
      }
    }
    if (currentStep == 2) {
      if (textThreeController.text.isEmpty) {
        const AdvanceSnackBar(message: "Enter value").show(context);
      } else {
        setState(() {
          prime = _mathController.getPrime;
        });
        return;
      }
    }
  }

  void signout() async {
    setState(() {
      _isLoading = true;
    });
    await _authController.signout;
    setState(() {
      _isLoading = false;
    });
    Get.offAll(() => const LoginScreen());
  }
}
