import 'package:flutter/material.dart';
import 'package:flutter_animation/app/data/models/tileModels.dart';
import 'package:flutter_animation/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_animation/app/data/partials/drawer_tile.dart';
import 'package:flutter_animation/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({
    super.key,
    required this.controllers,
  });

  final HomeController controllers;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with SingleTickerProviderStateMixin {
  List<TileModels> _tileList = [];
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Tween<Offset> _offset = Tween(begin: Offset(-1, 0), end: Offset(0, 0));

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();
    _animation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addTile();
    });
  }

  void _addTile() {
    var _data = [
      TileModels(title: 'Home', img: 'home.jpg', route: '${Routes.HOME}'),
      TileModels(title: 'Other', img: 'other.jpg', route: '${Routes.OTHER}'),
    ];
    Future ft = Future(() {});
    _data.forEach((data) {
      ft = ft.then((value) {
        return Future.delayed(
          Duration(milliseconds: 500),
          () {
            _tileList.add(TileModels(
                title: data.title, img: data.img, route: data.route));
            _listKey.currentState?.insertItem(_tileList.length - 1);
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final heightMQ = MediaQuery.of(context).size.height;
    return Stack(children: [
      Container(
        height: heightMQ,
        color: Colors.grey,
        child: Obx(
          () => AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: Colors.grey,
            width: Get.find<HomeController>().width.value.toDouble(),
            height: heightMQ,
            child: AnimatedList(
                key: _listKey,
                initialItemCount: _tileList.length,
                itemBuilder: (context, index, animation) {
                  final data = _tileList[index];
                  return SlideTransition(
                    position: _animation,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(data.route!),
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: DrawerTile(
                          controllers: Get.find<HomeController>(),
                          icon: data.img,
                          msg: data.title,
                        ),
                      ),
                    ),
                  );
                }),
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
