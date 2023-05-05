import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherController extends GetxController {
  var width = 70.obs;
  var opacity = 1.obs;
  Rx<Color> color = Colors.lightBlue.obs;
  var isFav = false.obs;
  late AnimationController controller;
}
