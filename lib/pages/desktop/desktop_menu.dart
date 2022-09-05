import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/mobile/mobile_page_controller.dart';
import 'package:remote_control_ui/common/widget_const/widget_const_arg.dart';
import 'package:remote_control_ui/pages/command_execution_page.dart';
import 'package:remote_control_ui/pages/device_about.dart';
import 'package:remote_control_ui/pages/log_page.dart';
import 'package:remote_control_ui/pages/nav_page.dart';
import 'package:remote_control_ui/pages/other_util_page.dart';
import 'package:remote_control_ui/pages/screenshot_page.dart';
import 'package:remote_control_ui/pages/source_manage.dart';

import '../../common/const/base_const_args.dart';

class DesktopMenu extends StatelessWidget {
  const DesktopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MobilePageController());

    return Scaffold(
      drawer: menuList(),
      body: Column(
        children: [
          diyTitle(),
          diyContent()
        ],
      ),
    );
  }

  Widget diyTitle(){
    return Builder(
      builder: (BuildContext context){
        return Container(
          color: BaseConstArgs().primaryColor,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    child: Image.asset("images/logo.png"),
                    onTap: () => Scaffold.of(context).openDrawer(),
                  ),
                  Text('智能合约一键梭哈', style: TextStyle(color: Colors.white, fontSize: 16))
                ],
              ),
              NavPage().winodwsButtons(),
            ],
          ),
        );
      }
    );
  }

  menuList() {
    return Container(
      width: 300,
      child: Drawer(
        child: ListView(
          children: WidgetConstArg().navList.map((e) => ListTile(
            title: Text(e.label),
            /// 点击事件
            onTap: () {
              Get.find<MobilePageController>().controller.jumpToPage(e.index);
              Get.find<MobilePageController>().update(e.index);
            },
          )).toList(),
        ),
      ),
    );
  }

  diyContent() {
    return Expanded(
      child: Row(
        children: [
          // onlineHostList(),
          Container(
            child: NavPage().list(),
            width: 350,
            color: BaseConstArgs().primaryColor,
          ),
          mainContent(),
          Container(
            width: 300,
            child: const LogPage(),
          )
        ],
      ),
    );
  }

  mainContent() {
    return Expanded(
        child: Container(
          // color: BaseConstArgs().primaryColor,
          decoration: BoxDecoration(
            color: BaseConstArgs().primaryColor,
            border: Border(
              right: BorderSide(color: Colors.white24, width: 1),
              left: BorderSide(color: Colors.white24, width: 1),
            )
          ),
          child: PageView(
            onPageChanged: (index) => Get.find<MobilePageController>().updatePageIndex(index),
            controller: Get.find<MobilePageController>().controller,
            children: [
              CommandExecutionPage(),
              ScreenshotPage(),
              SourceManage(),
              DeviceAbout(),
              OtherUtilPage()
            ],
          ),
        )
    );
  }
  
}
