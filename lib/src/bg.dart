import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'util.dart';
// 背景图
class Background {
  // 初始背景的偏移量
  double offsetY = -100.0;
  // 屏幕的宽度
  double screenWidth;
  // 屏幕的高度
  double screenHeight;
  // 画布滚动的速度
  double speed = 4;

  // 加载的背景图片
  ui.Image image;

  // 二张背景图的纵坐标点
  double y1 = 0.0;
  double y2 = 0.0;

  // 构造函数
  Background();

  // 初始化, 各种资源
  Future<VoidCallback> init() async {
    Size size = MediaQueryData.fromWindow(ui.window).size;
    image = await Utils.getImage('assets/images/bg.jpeg');
    screenWidth = size.width;
    screenHeight = size.height;
    y2 = y1 - screenHeight;
    return null;
  }

  // 绘图函数
  paint(Canvas canvas, Size size) async {
    Rect screenWrap = Offset(0.0, 0.0) & Size(screenWidth, screenHeight);
    Paint screenWrapPainter = new Paint();
    screenWrapPainter.color = Colors.red;
    screenWrapPainter.style = PaintingStyle.fill;
    // 我们绘制一个红色的底图
    canvas.drawRect(screenWrap, screenWrapPainter);

    canvas.save();
//    canvas.scale(1, screenHeight / image.height);
    y1 = y1 + 1 * speed;
    y2 = y2 + 1 * speed;
    if (y2 > screenHeight) {
      y2 = y1 - screenHeight;
    }
    if (y1 > screenHeight) {
      y1 = y2 - screenHeight;
    }
    Paint paint = new Paint();
    canvas.drawImageRect(image, Offset(0.0, 0.0) & Size(image.width.toDouble(), image.height.toDouble()), Offset(0.0, y1) & Size(screenWidth, screenHeight), paint);
    canvas.drawImageRect(image, Offset(0.0, 0.0) & Size(image.width.toDouble(), image.height.toDouble()), Offset(0.0, y2) & Size(screenWidth, screenHeight), paint);
    canvas.restore();
  }
}

