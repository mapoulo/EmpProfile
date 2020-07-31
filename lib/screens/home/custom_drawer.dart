import 'package:flutter/material.dart';
import 'package:user_crud/screens/home/home.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    super.initState();
  }

  void toggleAnimation() {
    if (controller.isDismissed) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  final double maxSlide = 120.0;

  @override
  Widget build(BuildContext context) {

    var myDrawer = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.yellow);

    var childContainer = Home();

    return GestureDetector(
        onTap: () {
          toggleAnimation();
        },
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              double slide = maxSlide * controller.value;
              double scale = 1 - controller.value * 0.3;
              return Stack(
                children: <Widget>[
                  myDrawer,
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    child: childContainer,
                    alignment: Alignment.centerRight,
                  )
                ],
              );
            }));
  }
}
