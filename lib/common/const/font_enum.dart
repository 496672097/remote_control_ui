
import 'package:flutter/material.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';

class FontEnum{

  Map<String, Widget> map = {
    'windows': const Icon(IconData(0xe75e, fontFamily: 'Iconfont'), size: 60, color: Colors.lightGreen),
    'ios': const Icon(IconData(0xe64b, fontFamily: 'Iconfont'), size: 60, color: Colors.lightGreen),
    'macos': const Icon(IconData(0xe73a, fontFamily: 'Iconfont'), size: 60, color: Colors.lightGreen),
    'linux': const Icon(IconData(0xf1e8, fontFamily: 'Iconfont'), size: 60, color: Colors.lightGreen),
    'android': const Icon(IconData(0xe6e3, fontFamily: 'Iconfont'), size: 60, color: Colors.lightGreen),
  };

}