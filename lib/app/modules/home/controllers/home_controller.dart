import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var width = 70.obs;
  var margin = 0.obs;
  var opacity = 1.obs;
  Rx<Color> color = Colors.lightBlue.obs;
  void drawer() {
    if (width.value == 70) {
      opacity.value = 1;
      width.value = 200;
    } else {
      width.value = 70;
      opacity.value = 70;
    }
  }
}
