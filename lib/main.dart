import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_clone/configuration/app_thems.dart';
import 'package:github_clone/configuration/sharepref.dart';
import 'package:github_clone/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initilization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //shared preference initilize here
  await Sharedpref.initilize();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TeamHub',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
