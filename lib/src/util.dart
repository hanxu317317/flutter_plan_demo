/**
 * Created with Android Studio.
 * User: 三帆
 * Date: 21/01/2019
 * Time: 16:56
 * email: sanfan.hx@alibaba-inc.com
 * tartget:  xxx
 */

//import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
class Utils {
  final context;
  Utils({this.context}) :super();

  static double getWidth() {
    return  ui.window.physicalSize.width;
  }
  static double getlRatio () {
    return ui.window.devicePixelRatio;
  }
  static double getHeight() {
    return  ui.window.physicalSize.height;
  }

  static Future<ui.Image> getImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
class CanvasOffset extends Offset {
 const CanvasOffset(double width, double height) : super(width, height) ;
}