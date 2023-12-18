import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:github_clone/configuration/app_assets.dart';
import 'package:github_clone/configuration/app_colors.dart';
import 'package:github_clone/configuration/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:github_clone/configuration/sharepref.dart';
import 'package:github_clone/features/home/screens/home_screen.dart';

import '../../../utils/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 83,
                width: 203,
                child: Image.asset(
                  AppAssets.gitLogo,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 240,
                width: 220,
                child: Image.asset(
                  AppAssets.loginImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Lets built from here ...",
                      style: AppStyles(context).titleSmall.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Our platform drives innovation with tools that boost developer velocity",
                      style: AppStyles(context).lablesmall.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryTextColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: () async {
                    try {
                      final response = await signInWithGitHub();
                      if (context.mounted) {
                        log(response.user.toString());
                        log(response.credential.toString());
                        log(response.additionalUserInfo.toString());
                        // saved some datas in local storage using sharedpreferences
                        await Sharedpref.saveOrgListUrl(response
                            .additionalUserInfo!.profile!["organizations_url"]);
                        log(Sharedpref.getOrgListUrl);
                        await Sharedpref.saveAccessToken(
                            response.credential!.accessToken!);
                        log(Sharedpref.getAccessToken);
                        if (mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                company: response.additionalUserInfo!
                                        .profile!["company"] ??
                                    "Nill",
                                name: response
                                    .additionalUserInfo!.profile!["name"],
                                userName:
                                    response.additionalUserInfo!.username!,
                                proImage: response.additionalUserInfo!
                                        .profile!["avatar_url"] ??
                                    "",
                              ),
                            ),
                          );
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      toast("${e.message}", isSuccess: false);
                      log(e.toString());
                    }
                  },
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                    13,
                  )))),
                  child: Text(
                    "Sign in with Github",
                    style: AppStyles(context).bodysmall.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
