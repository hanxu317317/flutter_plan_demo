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
import 'plan.dart';
import './hero.dart';
import 'util.dart';

enum GameStatus { loading, play, complete }
enum Directions { none, left, right, top, bottom }

class MainPainter extends CustomPainter {
  final Background background;
  final MainHero hero;
  final Size mediaSize;
  MainPainter({this.background, this.hero, this.mediaSize});
  @override
  void paint(Canvas canvas, Size size) {
    background.paint(canvas, size);
    hero.paint(canvas, size);
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
  Plan hero;

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
    hero = new MainHero();
    hero.init();
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
    return GestureDetector(
      child: CustomPaint(
          painter: MainPainter(background: background, hero: hero)
      ),
      onPanStart: (DragDownDetails) {
        print("onPanStart $DragDownDetails");
        hero.moveTo(DragDownDetails.globalPosition.dx, DragDownDetails.globalPosition.dy);

      },
      onPanUpdate: (DragDownDetails) {
        print("onPanUpdate $DragDownDetails");
        hero.moveTo(DragDownDetails.globalPosition.dx, DragDownDetails.globalPosition.dy);
      }
    );
//    return CustomPaint(
//      painter: MainPainter(background: background, hero: hero),
//    );
  }
}
