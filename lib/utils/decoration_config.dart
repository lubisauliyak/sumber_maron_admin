import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF2D68AE);
const kSecondaryColor = Color(0xFF398AB9);
const kGreenColor = Colors.green;
const kRedColor = Colors.red;
const kOrangeColor = Colors.orange;
const kBlackColor = Colors.black;
const kWhiteColor = Colors.white;
const kGreyColor = Colors.grey;

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    colorSchemeSeed: kPrimaryColor,
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    labelStyle: const TextStyle(color: kPrimaryColor),
    suffixIconColor: kPrimaryColor,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: kGreyColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: kSecondaryColor),
    ),
  );
}
