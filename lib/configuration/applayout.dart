import 'package:flutter/material.dart';

class AppLayout {
  //* Paddings
  static const EdgeInsets screenPadding = EdgeInsets.all(15);
  static const EdgeInsets listPadding = EdgeInsets.fromLTRB(16, 0, 16, 0);
  static const EdgeInsets cardPadding = EdgeInsets.all(12);
  static const EdgeInsets screenPaddingMedium = EdgeInsets.all(15.0);
  static const EdgeInsets textPadding = EdgeInsets.only(
    left: 10.0,
    right: 10.0,
  );
  static const EdgeInsets containerPadding = EdgeInsets.all(10);
  static const EdgeInsets dividerPadding = EdgeInsets.all(10.0);
  static const EdgeInsets profileContainerSpace = EdgeInsets.all(15.0);
  static const EdgeInsets chipPadding = EdgeInsets.all(3.0);
  //* Corner Radius
  static const double cornerRadius = 10.0;
  static const double imgHeight = 100.0;
  static const double otpField = 8.0;

  //* Grid Axis Spacers
  static const double axisSpacing = 10.0;

  //* Sizedbox Axis Spacers
  static const double spacer = 10.0;

  static const smallH = SizedBox(
    height: 5,
  );
  static const spaceH10 = SizedBox(
    height: 10,
  );
  static const spaceH15 = SizedBox(
    height: 15,
  );
  static const spaceH20 = SizedBox(
    height: 20,
  );
  static const spaceH25 = SizedBox(
    height: 25,
  );
  static const spaceH30 = SizedBox(
    height: 30,
  );
  static const spaceH40 = SizedBox(
    height: 40,
  );
  static const spaceH50 = SizedBox(
    height: 50,
  );

  // sized box width

  static const smallW = SizedBox(
    width: 5,
  );
  static const spaceW10 = SizedBox(
    width: 10,
  );
  static const spaceW15 = SizedBox(
    width: 15,
  );

  static const spaceW20 = SizedBox(
    width: 20,
  );
  static const spaceW25 = SizedBox(
    width: 25,
  );
  static const spaceW30 = SizedBox(
    width: 30,
  );
    static const spaceW40 = SizedBox(
    width: 40,
  );
    static const spaceW50 = SizedBox(
    width: 50,
  );

  static const bottomSpace = SizedBox(
    height: 100,
  );
}
