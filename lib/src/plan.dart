/**
 * Created with Android Studio.
 * User: 三帆
 * Date: 25/01/2019
 * Time: 16:50
 * email: sanfan.hx@alibaba-inc.com
 * tartget:  xxx
 */

import 'package:flutter/material.dart';

abstract class Plan {
  // 初始化函数
  void init() {}
  void moveTo(double x, double y) {}
  void destroy() {}
  void paint(Canvas canvas, Size size) async {}
}
