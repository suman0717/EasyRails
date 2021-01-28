import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockwidth = 0;
  static double _blockHeight = 0;

  static double textMultipier;
  static double imageSizeMultipier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation){
    if (orientation == Orientation.portrait){
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if(_screenHeight < 450){
        isMobilePortrait = true;
      }
      print('Portrait');
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
      print('Landscape');
    }

    _blockwidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultipier = _blockHeight;
    imageSizeMultipier = _blockwidth;

    heightMultiplier = _blockHeight;
    widthMultiplier = _blockwidth;
    print(_blockwidth);
    print(_blockHeight);
  }
}