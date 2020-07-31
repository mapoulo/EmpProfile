import 'package:flutter/material.dart';
import 'package:user_crud/bloc/provider_bloc.dart';
import 'package:user_crud/bloc/state.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[TheImage(), BottomSheet()],
      ),
    );
  }
}

class TheImage extends StatefulWidget {
  @override
  _TheImageState createState() => _TheImageState();
}

class _TheImageState extends State<TheImage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
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
          builder: (context, snapshot) {
            snapshot.data ? forward() : reverse();
            return ScaleTransition(
              scale: controller,
             
                child: Container(
                  height: 270,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.yellow,
                ),
            
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
            reverseCurve: Curves.easeIn));
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
          controller.isDismissed ?  forward() : reverse();
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
