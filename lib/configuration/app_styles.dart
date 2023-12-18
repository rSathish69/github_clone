import 'package:flutter/material.dart';

class AppStyles {
  BuildContext context;

  AppStyles(this.context);

  //constant style

  TextStyle get titleLarge => Theme.of(context).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(context).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(context).textTheme.titleSmall!;
  TextStyle get bodysmall => Theme.of(context).textTheme.bodySmall!;
  TextStyle get lablesmall => Theme.of(context).textTheme.labelSmall!;




}
