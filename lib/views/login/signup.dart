import 'package:e_commerce_app/views/screens/home_page.dart';
import 'package:e_commerce_app/views/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/firebase_service.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ('signup page');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.amber,
      body: Form(
        key: _key,
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) return const HomePage();
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.network(
                            'https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg'),
                        const SizedBox(height: 20),
                        const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: usernameController,
                          validator: validateUsername,
                          decoration: const InputDecoration(
                              label: Text('Username'),
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: emailController,
                          validator: validateEamil,
                          decoration: const InputDecoration(
                            label: Text('E-mail'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          obscureText: _passwordVisible,
                          controller: passwordController,
                          validator: validatePassword,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: (() {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              }),
                              icon: Icon(_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => const Login()),
                                  ),
                                );
                              }),
                              child: const Text(
                                "Log In",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )

                            // Text(
                            //   "Forget Password?",
                            //   style: TextStyle(color: Colors.blue),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                              onPressed: (() async {
                                if (_key.currentState!.validate()) {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim());
                                }
                                Firestore().adduserdetails(
                                    usernameController.text.trim(),
                                    emailController.text,
                                    passwordController.text);
                              }),
                              child: const Text("Sign up")),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

String? validateUsername(String? formUsername) {
  if (formUsername == null || formUsername.isEmpty) {
    return "Username is required.";
  }
  return null;
}

String? validateEamil(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return "E-mail address is required.";
  }

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required';
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return '''
              Password must be at least 8 characters,
             include an uppercase letter, number and symbol.
   ''';
  }

  return null;
}
