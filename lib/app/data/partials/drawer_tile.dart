import 'package:flutter/material.dart';
import 'package:flutter_animation/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.controllers,
    required this.icon,
    required this.msg,
  });

  final HomeController controllers;
  final IconData? icon;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: controllers.color.value,
            width: controllers.width.value.toDouble(),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CircleAvatar(
                      child: Hero(
                        tag: '$msg',
                        child: Image.asset(
                          'assets/other.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 55),
            child: TweenAnimationBuilder(
              tween: controllers.width.value == 200
                  ? Tween<double>(begin: 0, end: 1)
                  : Tween<double>(begin: 0.3, end: 0),
              child: Text(
                msg!,
                style: TextStyle(fontSize: 18),
              ),
              duration: Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Container(
                  height: 30,
                  width: value * 145,
                  child: Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: value * 10),
                      child: child,
                    ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
