import 'package:flutter/material.dart';
import 'package:github_clone/configuration/app_styles.dart';
import 'package:github_clone/configuration/applayout.dart';

class NoData extends StatelessWidget {
  final String message;
  const NoData({super.key, this.message = "No Data Found!"});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.cleaning_services,
          color: Colors.blue,
        ),
        AppLayout.spaceH10,
        Text(
          message,
          style: AppStyles(context).titleSmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
        )
      ],
    );
  }
}
