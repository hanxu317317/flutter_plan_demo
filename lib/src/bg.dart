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
  double speed = 10;

  // 加载的背景图片
  ui.Image image;

  // 二张背景图的纵坐标点
  double y1 = 100.0;
  double y2 = 0.0;

  // 构造函数
  Background();

  // 初始化, 各种资源
  Future<VoidCallback> init() async {
    Size size = MediaQueryData.fromWindow(ui.window).size;
    image = await Utils.getImage('assets/images/bg.jpeg');
    screenWidth = size.width;
    screenHeight = size.height;
    y2 = y1 - image.height;
    return null;
  }

  // 绘图函数
  paint(Canvas canvas, Size size) async {
    print("background paint");
    Rect screenWrap = Offset(0.0, 0.0) & Size(screenWidth, screenHeight);
    Paint screenWrapPainter = new Paint();
    screenWrapPainter.color = Colors.red;
    screenWrapPainter.style = PaintingStyle.fill;
    // 我们绘制一个红色的底图
    canvas.drawRect(screenWrap, screenWrapPainter);

//    canvas.save();
    canvas.scale(1, screenHeight / image.height);
    y1 = y1 + 1 * speed;
    y2 = y2 + 1 * speed;
    if (y2 > image.height) {
      y2 = y1 - image.height;
    }
    if (y1 > image.height) {
      y1 = y2 - image.height;
    }
////    print("y1 = $y1, y2 = $y2, height = $screenHeight");
    Paint paint = new Paint();
    canvas.drawImage(image, Offset(0, y1), paint);
    canvas.drawImage(image, Offset(0, y2), new Paint());
//    canvas.restore();
  }
}

