import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double horizontalBloc;
  static late double verticalBloc;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    horizontalBloc = screenWidth / 100;
    verticalBloc = screenHeight / 100;
  }
}

// Get the proportionate height as per screen size
double getHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  double proportionateHeight;
  // 872 is the layout height that designer use
  double layoutHeightDesigner = 872.0;
  if (screenHeight < layoutHeightDesigner) {
    proportionateHeight = (inputHeight / layoutHeightDesigner) * screenHeight;
  } else if (screenHeight > layoutHeightDesigner) {
    proportionateHeight = inputHeight;
  } else {
    proportionateHeight = inputHeight;
  }
  return proportionateHeight;
}

// Get the proportionate width as per screen size
double getWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  double proportionateWidth;
  // 390 is the layout width that designer use
  double layoutWidthDesigner = 390.0;
  if (screenWidth < layoutWidthDesigner) {
    proportionateWidth = (inputWidth / layoutWidthDesigner) * screenWidth;
  } else if (screenWidth > layoutWidthDesigner) {
    proportionateWidth = inputWidth;
  } else {
    proportionateWidth = inputWidth;
  }
  return proportionateWidth;
}
