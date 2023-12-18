import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_clone/configuration/app_assets.dart';
import 'package:github_clone/features/authentication/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset(
                AppAssets.gitLogo,
                fit: BoxFit.contain,
              ),
            ),
            // Text(
            //   "TeamHub",
            //   style: AppStyles(context).titleLarge.copyWith(
            //         fontWeight: FontWeight.bold,
            //       ),
            // ),
            const SizedBox(
              height: 10,
            ),
            const CupertinoActivityIndicator(
              radius: 8,
            )
          ],
        ),
      ),
    );
  }
}
