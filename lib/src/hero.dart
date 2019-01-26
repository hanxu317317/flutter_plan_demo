import 'plan.dart';
import 'package:flutter/material.dart';
import 'util.dart';
import 'dart:ui' as ui;
import 'dart:math';
// stay 无人控制, 自由飞行
// move 有人控制, 飞行运动状态
// die  死了

enum PlanStatus {stay, move, die}

class MainHero extends Plan {
  // 中心点坐标 x
  double x = 100.0;
  // 飞行目标点
  double _x;
  // 中心点坐标 y
  double y = 100.0;
  double _y;
  // 运动速速
  double speed = 20;
  double speedRadios = 0.2;
  // 战机宽度
  double width = 132.0;
  // 战机高度
  double height = 160.0;
  // 战机血量
  int blood = 1;
  // 战机是否无敌, 备用
  bool invincible = false;

  // 飞机状态
  PlanStatus status = PlanStatus.stay;

  int frameNumber = 2;

  // 当前帧数
  int frameIndex = 0;

  ui.Image image;

  @override
  void init() async {
    Size size = MediaQueryData.fromWindow(ui.window).size;

    image = await Utils.getImage('assets/images/hero.png');
    // TODO: implement init
  }
  @override
  void moveTo(double x, double y) {
    // TODO: implement moveTo
    this._x = x;
    this._y = y;
    this.status = PlanStatus.move;
  }
  @override
  void destroy() {
    // TODO: implement destroy
    super.destroy();
  }
  // 动态获取飞机的长帧图的绘制区域
  Rect getPlanAreaSize(int _frameIndex) {

    double perFrameWidth = image.width / frameNumber;
    double offsetX = perFrameWidth * _frameIndex;
    double offsetY = 0;

    if (offsetX >= image.width) {
      frameIndex = 0;
      return this.getPlanAreaSize(0);
    }

    return Offset(offsetX, offsetY) & Size(66.0, 80.0);

  }
  void calculatePosition() {
    Point  p1 = Point(x, y);
    Point  p2 = Point(_x, _y);
    double distance = p1.distanceTo(p2);
    // 避免抖动, 做一个判断. 距离
    if (distance < 10) {
      x = _x;
      y = _y;
      status = PlanStatus.stay;
      return null;
    }
    double flyRadian = acos(((y - _y) / distance).abs());
    if (_x < x) {
      x -= speed * sin(flyRadian);
    } else {
      x += speed * sin(flyRadian);
    }
    if (_y < y) {
      y -= speed * cos(flyRadian);
    } else {
      y += speed * cos(flyRadian);
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    if (status == PlanStatus.move) {
      calculatePosition();
    }
    print("X: $x, Y: $y, _X: $_x, _Y: $_y");
    Rect paintArea = Offset(x, y) & Size(width, height);
    Rect planArea = this.getPlanAreaSize(frameIndex);
    canvas.save();
    // 将画布向左上方偏移, 把绘图点, 迁移到飞机正中心
    canvas.translate( -width / 2, -height / 2);
    canvas.drawImageRect(image, planArea, paintArea, new Paint());
    frameIndex++;
    canvas.restore();
  }
}
