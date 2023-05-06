import 'package:flutter/material.dart';
import 'package:flutter_animation/app/data/models/dataModels.dart';
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
  List<DataModels> _dataTiles = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
// Kita inisialisasi Animation Controller
  AnimationController? _controller;

  // lalu inisialisasi Animation untuk color tweenya
  Animation? _colorAnimation;
  Animation? _sizeAnimation;
  Tween<Offset>? _offset;
  Animation<double>? _curve;
  @override
  void initState() {
    super.initState();

    // Buat vsync dan duration dari controllernya
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _curve = CurvedAnimation(parent: _controller!, curve: Curves.slowMiddle);

    // Lalu buat animasi dari colortween nya
    _colorAnimation =
        ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_curve!);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 30, end: 40), weight: 5),
      TweenSequenceItem(tween: Tween(begin: 40, end: 30), weight: 5),
    ]).animate(_curve!);

    // Kita cek status dari animation controllernya. Kalau animation controllernya sudah complete berarti isFav true.
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.find<OtherController>().isFav.value = true;
      } else if (status == AnimationStatus.dismissed) {
        Get.find<OtherController>().isFav.value = false;
      }
    });

    _offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addData();
    });
  }

  @override
  void dispose() {
    super.dispose;
    _controller!.dispose();
  }

  _addData() {
    var _data = [
      DataModels(
        title: 'Labuan Bajo',
        description:
            'Sit non cillum veniam proident est esse. Nostrud occaecat ut eu pariatur enim exercitation sunt proident dolor. In pariatur aliqua officia dolore nisi in in enim in aliqua proident labore irure magna. Eiusmod in pariatur qui sunt laboris velit amet pariatur occaecat exercitation minim. Aute enim magna irure mollit id labore.',
      ),
      DataModels(
        title: 'Aceh',
        description:
            'Sit non cillum veniam proident est esse. Nostrud occaecat ut eu pariatur enim exercitation sunt proident dolor. In pariatur aliqua officia dolore nisi in in enim in aliqua proident labore irure magna. Eiusmod in pariatur qui sunt laboris velit amet pariatur occaecat exercitation minim. Aute enim magna irure mollit id labore.',
      ),
      DataModels(
        title: 'Papua',
        description:
            'Sit non cillum veniam proident est esse. Nostrud occaecat ut eu pariatur enim exercitation sunt proident dolor. In pariatur aliqua officia dolore nisi in in enim in aliqua proident labore irure magna. Eiusmod in pariatur qui sunt laboris velit amet pariatur occaecat exercitation minim. Aute enim magna irure mollit id labore.',
      ),
      DataModels(
        title: 'Jawa',
        description:
            'Sit non cillum veniam proident est esse. Nostrud occaecat ut eu pariatur enim exercitation sunt proident dolor. In pariatur aliqua officia dolore nisi in in enim in aliqua proident labore irure magna. Eiusmod in pariatur qui sunt laboris velit amet pariatur occaecat exercitation minim. Aute enim magna irure mollit id labore.',
      ),
    ];
    _data.forEach((data) {
      _dataTiles.add(DataModels(
        title: data.title,
        description: data.description,
      ));
      _listKey.currentState!.insertItem(_dataTiles.length - 1);
    });
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
        body: Column(
          children: [
            Hero(
              tag: 'Other',
              child: Padding(
                padding: EdgeInsets.only(top: widthQ * 0.05),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Labuan Bajo',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                size: _sizeAnimation!.value,
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
                    padding: EdgeInsets.only(top: value * 10),
                    child: Opacity(
                      opacity: value,
                      child: child,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widthQ * 0.05),
                child: Container(
                  width: widthQ * 0.9,
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: _dataTiles.length,
                    itemBuilder: (context, index, animation) {
                      final data = _dataTiles[index];
                      return SlideTransition(
                          position: animation.drive(_offset!),
                          child: Text(data.description!));
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
