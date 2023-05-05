import 'package:flutter/material.dart';
import 'package:flutter_animation/app/data/partials/drawer_screen.dart';
import 'package:flutter_animation/app/modules/home/controllers/other_controller.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class OtherView extends StatefulWidget {
  @override
  State<OtherView> createState() => _OtherViewState();
}

class _OtherViewState extends State<OtherView>
    with SingleTickerProviderStateMixin {
  final otherC = Get.put(OtherController());

  final lastArg = Get.arguments;

  @override
  // Kita inisialisasi Animation Controller
  AnimationController? _controller;

  // lalu inisialisasi Animation untuk color tweenya
  Animation? _colorAnimation;
  void initState() {
    // Buat vsync dan duration dari controllernya
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    // Lalu buat animasi dari colortween nya
    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller!);

    // Kita cek status dari animation controllernya. Kalau animation controllernya sudah complete berarti isFav true.
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.find<OtherController>().isFav.value = true;
      } else if (status == AnimationStatus.dismissed) {
        Get.find<OtherController>().isFav.value = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightQ = MediaQuery.of(context).size.height;
    final widthQ = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: const Text('Other Page'),
            centerTitle: true,
            leading: GetBuilder(
                init: HomeController(),
                builder: (controller) {
                  return Get.currentRoute == '/home'
                      ? Obx(() => ElevatedButton(
                            onPressed: () {
                              controller.drawer();
                            },
                            child: otherC.width.value == 200
                                ? Icon(Icons.keyboard_arrow_left_rounded)
                                : Icon(Icons.keyboard_arrow_right_rounded),
                          ))
                      : IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Icons.arrow_back_ios));
                })),
        body: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'Other',
                child: Padding(
                  padding: EdgeInsets.all(widthQ * 0.05),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: widthQ * 0.9,
                      child: Image.asset(
                        'assets/other.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthQ * 0.05),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  child: Container(
                    width: widthQ * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: widthQ * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Labuan Bajo',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        // Buat animation builder agar kita dapat melihat proses
                        // per perubahan. Masukan animation: dengan
                        // animation controller dan masukan colortweennya untuk merubah
                        // sesuatu data di animation buildernya
                        AnimatedBuilder(
                          animation: _controller!,
                          builder: (context, _) {
                            return IconButton(
                              onPressed: () {
                                otherC.isFav.value
                                    ? _controller!.reverse()
                                    : _controller!.forward();
                              },
                              icon: Icon(Icons.favorite,
                                  color: _colorAnimation!.value),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  duration: Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.only(top: value * 20),
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ]));
  }
}
