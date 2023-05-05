import 'package:flutter/material.dart';
import 'package:flutter_animation/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_animation/app/data/partials/drawer_tile.dart';
import 'package:flutter_animation/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
    required this.controllers,
  });

  final HomeController controllers;

  @override
  Widget build(BuildContext context) {
    final heightMQ = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
        height: heightMQ,
        color: Colors.grey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DrawerTile(
                    controllers: controllers,
                    icon: Icons.home,
                    msg: 'Home',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.OTHER, arguments: 'Other'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DrawerTile(
                      controllers: controllers,
                      icon: Icons.dashboard_customize_sharp,
                      msg: 'Other',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        right: 0,
        top: heightMQ * 0.5,
        child: GetBuilder(
            init: HomeController(),
            builder: (controller) => Obx(
                  () => Container(
                    alignment: Alignment.center,
                    width: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),

                      // ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.black),
                      onPressed: () {
                        controller.drawer();
                      },
                      child: Get.find<HomeController>().width.value == 200
                          ? Icon(
                              Icons.keyboard_arrow_left_rounded,
                            )
                          : Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                  ),
                )),
      ),
    ]);
  }
}
