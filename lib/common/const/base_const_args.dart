import 'dart:io';

import 'package:flutter/material.dart';

class BaseConstArgs{

  // 是否移动端设备
  bool isMobile = Platform.isAndroid || Platform.isIOS;
  // 是否桌面设备
  bool isDeskTop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  // 主色调
  Color primaryColor = const Color.fromRGBO(37, 6, 36, 1);

}