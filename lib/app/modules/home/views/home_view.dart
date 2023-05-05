import 'package:flutter/material.dart';
import 'package:flutter_animation/app/data/partials/drawer_screen.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final heightQ = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Row(children: [
        Stack(
          children: [
            Column(
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  child: Text('Animation Text'),
                  duration: Duration(milliseconds: 500),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: child,
                    );
                  },
                )
              ],
            ),
            DrawerScreen(controllers: homeC),
          ],
        ),
      ])),
    );
  }
}
