import 'package:e_commerce_app/controller/provider_file.dart';
import 'package:e_commerce_app/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderFile(),
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home:const SplashScreen()
      ),
    );
  }
}
