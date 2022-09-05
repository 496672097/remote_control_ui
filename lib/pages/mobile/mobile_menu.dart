import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/args_controller.dart';
import 'package:remote_control_ui/common/controller/mobile/mobile_page_controller.dart';
import 'package:remote_control_ui/pages/device_about.dart';
import 'package:remote_control_ui/pages/other_util_page.dart';
import 'package:remote_control_ui/pages/screenshot_page.dart';
import 'package:remote_control_ui/pages/source_manage.dart';

import '../command_execution_page.dart';
import '../log_page.dart';

class MobileMenu extends StatelessWidget {
  const MobileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MobilePageController());

    return SafeArea(
      child: GetBuilder<ArgsController>(
        init: Get.find<ArgsController>(),
        builder: (argsController){
          return Scaffold(
            body: PageView(
              onPageChanged: (index) => Get.find<MobilePageController>().updatePageIndex(index),
              controller: Get.find<MobilePageController>().controller,
              children: [
                CommandExecutionPage(),
                ScreenshotPage(),
                SourceManage(),
                DeviceAbout(),
                LogPage(),
                OtherUtilPage()
              ],
            ),
            bottomNavigationBar: GetBuilder<MobilePageController>(
              init: Get.find<MobilePageController>(),
              builder: (controller){
                return BottomNavigationBar(
                  currentIndex: controller.pageIndex,
                  onTap: (index){
                    controller.controller.jumpToPage(index);
                    controller.updatePageIndex(index);
                  },
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.keyboard), label: '命令执行'),
                    BottomNavigationBarItem(icon: Icon(Icons.device_hub), label: '硬件控制'),
                    BottomNavigationBarItem(icon: Icon(Icons.source), label: '资源管理'),
                    BottomNavigationBarItem(icon: Icon(Icons.usb), label: '键鼠记录'),
                    BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
                    BottomNavigationBarItem(icon: Icon(Icons.add_box), label: '其他工具'),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
