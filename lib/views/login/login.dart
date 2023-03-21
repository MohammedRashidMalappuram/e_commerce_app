import 'package:e_commerce_app/services/firebase_service.dart';
import 'package:e_commerce_app/views/login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.amber,
      body: SafeArea(
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
                  "Log In",
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      label: Text('E-mail'), border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  obscureText: _passwordVisible,
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
                        ('signup');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const Signup()),
                          ),
                        );
                      }),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: (() {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim());
                      }),
                      child: const Text("Log In")),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      child: const Divider(),
                    ),
                    const Text("Or"),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 40,
                      child: const Divider(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    //google signin
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuthMethods().signInWithGoogle();
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 242, 241, 239)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SvgPicture.network(
                                'https://www.vectorlogo.zone/logos/google/google-icon.svg'),
                            const SizedBox(height: 10),
                            const Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: (() {}),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 7, 7, 7)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/images/apple.svg'),
                            const SizedBox(height: 25),
                            const Text(
                              'Sign in with Apple',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
