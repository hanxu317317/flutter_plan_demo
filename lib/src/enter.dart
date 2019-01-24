/**
 * Created with Android Studio.
 * User: 三帆
 * Date: 21/01/2019
 * Time: 16:49
 * email: sanfan.hx@alibaba-inc.com
 * tartget:  xxx
 */

import 'package:flutter/material.dart';
import 'bg.dart';
import 'dart:async';

import 'util.dart';

enum GameStatus { loading, play, complete }
enum Directions { none, left, right, top, bottom }

class MainPainter extends CustomPainter {
  final Background background;
  final Size mediaSize;

  MainPainter({this.background, this.mediaSize});
  @override
  void paint(Canvas canvas, Size size) {
    background.paint(canvas, size);
    // TODO: implement paint
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class GameEnter extends StatefulWidget {
  _GameEnter createState() => _GameEnter();
}

class _GameEnter extends State<GameEnter> with TickerProviderStateMixin  {

  GameStatus gameStatus = GameStatus.loading;
  Animation<double> animation;
  AnimationController controller;
  int index = 0;
  Background background;


  initState() {
    controller = new AnimationController(
        duration: const Duration(seconds: 1), vsync: this);


    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    background = new Background();

    background.init().then((val) {
      setState(() {
        gameStatus = GameStatus.play;
      });
      showStartAnimation();
    });
  }
  void showStartAnimation() {
    controller.forward();
  }



  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    if (gameStatus == GameStatus.loading) {
      return Center(
        child: Text('Loading', style: TextStyle(decoration: TextDecoration.none)),
      );
    }


    return CustomPaint(
      painter: MainPainter(background: background),
    );
  }
}
