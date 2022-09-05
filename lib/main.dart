import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:remote_control_ui/common/controller/socket_controller.dart';
import 'package:remote_control_ui/pages/desktop/desktop_menu.dart';
import 'package:remote_control_ui/pages/menu_page.dart';
import 'package:remote_control_ui/pages/nav_page.dart';


void main() {
  // 注入连接控制器
  Get.put(SocketController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: NavPage(),
    // theme: ThemeData(
    //   // fontFamily: '楷体',
    //   primaryColor: Colors.white,
    //   textTheme: TextTheme(
    //     bodyText2: TextStyle(
    //       color: Colors.grey
    //     )
    //   )
    // ),
    getPages: [
      GetPage(name: '/nav', page: () => NavPage()),
      GetPage(name: '/menuPage', page: () => const MenuPage()),
      GetPage(name: '/desktopMenuPage', page: () => const DesktopMenu())
    ],
  ));

  doWhenWindowReady(() {
    const initialSize = Size(1440, 750);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}