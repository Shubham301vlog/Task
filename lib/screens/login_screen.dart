import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';
import '../utils/textfield_styles.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Sample App",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "User Name",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: userNameController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: inputOutlineBorder,
                    focusedBorder: inputOutlineBorder,
                    disabledBorder: inputOutlineBorder,
                    enabledBorder: inputOutlineBorder,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Field cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: inputOutlineBorder,
                    focusedBorder: inputOutlineBorder,
                    disabledBorder: inputOutlineBorder,
                    enabledBorder: inputOutlineBorder,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    _login();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    bool success = await ApiService.login(
      userNameController.text,
      passwordController.text,
    );

    if (success) {
      // Navigate to another screen on success
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
                userName: userNameController.text,
                password: passwordController.text),
          ));
    } else {
      // Show error message on failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed! Please try again.')),
      );
    }
  }
}
