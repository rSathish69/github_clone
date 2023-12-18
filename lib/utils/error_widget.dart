import 'package:flutter/material.dart';
import 'package:github_clone/configuration/app_colors.dart';
import 'package:github_clone/configuration/app_styles.dart';
import 'package:github_clone/configuration/applayout.dart';

class ErrorWid extends StatelessWidget {
  final String errorText;
  const ErrorWid({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.warning,
          ),
          AppLayout.spaceH10,
          Text(
            errorText,
            style: AppStyles(context).titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }
}
