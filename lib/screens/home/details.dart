import 'package:flutter/material.dart';
import 'package:user_crud/bloc/provider_bloc.dart';
import 'package:user_crud/bloc/state.dart';
import 'package:user_crud/models/userdata.dart';

class Details extends StatelessWidget {
  
  final flower;
  Details({this.flower});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[TheImage(flower: flower), BottomSheet()],
      ),
    );
  }
}

class TheImage extends StatefulWidget {
   final flower;
  TheImage({this.flower});
  @override
  _TheImageState createState() => _TheImageState(flower: flower);
}

class _TheImageState extends State<TheImage>
    with SingleTickerProviderStateMixin {

      final flower;
      _TheImageState({this.flower});
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 1.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Curves.easeIn, reverseCurve: Curves.easeIn));
    super.initState();
  }

  forward() {
    controller.forward();
  }

  reverse() {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: StreamBuilder(
          initialData: theProvider.isAnimating,
          stream: stateBloc.animationStatus,
          builder: (context, snapshot) {
            snapshot.data ? forward() : reverse();
            return ScaleTransition(
              scale: controller,
              child:Hero(
                tag: "image",
                child:  Container(
                height: 270,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(flower.flowerName)
                    )
                ),
              ),
              )
            );
          }),
    );
  }
}

class BottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  double topSheet = 271.0;
  double minSheet = 100.0;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: topSheet, end: minSheet).animate(
        CurvedAnimation(
            parent: controller,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  forward() {
    controller.forward();
    stateBloc.toggleAnimationStatus();
  }

  reverse() {
    controller.reverse();
    stateBloc.toggleAnimationStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      child: GestureDetector(
        onTap: () {
          controller.isDismissed ? forward() : reverse();
        },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          if (dragEndDetails.primaryVelocity < 0.0) {
            forward();
          } else if (dragEndDetails.primaryVelocity > 0.0) {
            reverse();
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: Column(
            children: <Widget>[
              Container(
                height: 2,
                width: 250,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
