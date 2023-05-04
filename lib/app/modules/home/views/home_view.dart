import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final heightQ = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Animation'),
          centerTitle: true,
          leading: GetBuilder(
              init: HomeController(),
              builder: (controller) => Obx(
                    () => ElevatedButton(
                      onPressed: () {
                        controller.drawer();
                      },
                      child: homeC.width.value == 200
                          ? Icon(Icons.keyboard_arrow_left_rounded)
                          : Icon(Icons.keyboard_arrow_right_rounded),
                    ),
                  )),
        ),
        body: Row(children: [
          Stack(children: [
            Container(
              height: heightQ,
              color: Colors.black45,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DrawerTile(
                        homeC: homeC,
                        icon: Icons.home,
                        msg: 'Home',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DrawerTile(
                        homeC: homeC,
                        icon: Icons.dashboard_customize_sharp,
                        msg: 'Other',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DrawerTile(
                        homeC: homeC,
                        icon: Icons.dashboard_customize_sharp,
                        msg: 'Other',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DrawerTile(
                        homeC: homeC,
                        icon: Icons.dashboard_customize_sharp,
                        msg: 'Other',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DrawerTile(
                        homeC: homeC,
                        icon: Icons.dashboard_customize_sharp,
                        msg: 'Other',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DrawerTile(
                        homeC: homeC,
                        icon: Icons.dashboard_customize_sharp,
                        msg: 'Other',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DrawerTile(
                        homeC: homeC,
                        icon: Icons.dashboard_customize_sharp,
                        msg: 'Other',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DrawerTile(
                        homeC: homeC,
                        icon: Icons.dashboard_customize_sharp,
                        msg: 'Other',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
          Column(
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                child: Text('Animation Text'),
                duration: Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(top: value * 20),
                      child: child,
                    ),
                  );
                },
              )
            ],
          ),
        ]));
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.homeC,
    required this.icon,
    required this.msg,
  });

  final HomeController homeC;
  final IconData? icon;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: homeC.color.value,
            width: homeC.width.value.toDouble(),
            child: Column(
              children: [
                Container(
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        child: CircleAvatar(
                          child: Icon(icon),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 55),
              child: TweenAnimationBuilder(
                tween: homeC.width.value == 200
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
          ),
        ]));
  }
}
