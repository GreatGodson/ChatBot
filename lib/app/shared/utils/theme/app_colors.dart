import 'dart:math';

import 'package:flutter/material.dart';

/// defines the app colors
class AppColors {
  static const Color primaryColor = Color(0XFF343541);
  static const Color textFormFillColor = Color(0XFF40414F);
  static const Color logoColor = Color(0XFF8E8E9E);
  static const Color botChatColor = Color(0XFF434654);
  static const Color senderChatColor = Color(0XFFE67F22);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color greenColor = Colors.green;
  static const Color yellowAccent = Colors.yellowAccent;
  static const orangeColor = Colors.orange;
  static const pinkColor = Colors.pink;
  static const blueColor = Colors.blue;

  static const Color iconColor = Color(0XFF8E8E9F);

  static Color randomColor() {
    var colors = [
      AppColors.greenColor,
      AppColors.yellowAccent,
      AppColors.orangeColor,
      AppColors.pinkColor,
      AppColors.whiteColor,
    ];
    return colors[Random().nextInt(colors.length)];
  }
}
