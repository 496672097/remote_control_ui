import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';
import 'package:remote_control_ui/common/controller/screenshot_conrtoller.dart';
import 'package:remote_control_ui/common/controller/source_manage_controller.dart';

import '../common/controller/listener_controller.dart';

class ScreenshotPage extends StatelessWidget {
  const ScreenshotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ScreenshotController());
    Get.put(ListenerController());
    Get.put(SourceManageController());

    return Column(
      children: [
        BaseConstArgs().isMobile ? SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: Get.find<ScreenshotController>().x,
                  decoration: const InputDecoration(
                    hintText: 'x轴坐标'
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: Get.find<ScreenshotController>().y,
                  decoration: const InputDecoration(
                      hintText: 'y轴坐标'
                  ),
                ),
              ),
              ElevatedButton(onPressed: () => Get.find<ScreenshotController>().moveMouse(), child: Icon(Icons.move_down))
            ],
          ),
        ) : const SizedBox(),
        BaseConstArgs().isMobile ? SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: mouseEventListButton(),
          ),
        ) : const SizedBox(),
        BaseConstArgs().isMobile ? TextField(
          controller: Get.find<ScreenshotController>().sequence,
          onSubmitted: (val) => Get.find<ScreenshotController>().writeKeySequence(),
          decoration: const InputDecoration(
            hintText: '输入键盘序列操作字符串，详情在设置中查看'
          ),
        ) : const SizedBox(),
        Expanded(
          child: Stack(
            children: [
              GetBuilder<ListenerController>(
                init: Get.find<ListenerController>(),
                builder: (control){
                  return control.bytes.isEmpty ? Container() : Image.memory(control.bytes);
                },
              ),
              Positioned(
                bottom: 0,
                child: FloatingActionButton(
                  onPressed: () => Get.find<ListenerController>().getScreenshot(),
                  child: const Icon(Icons.screen_share)
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: FloatingActionButton(
                    onPressed: () => Get.find<ListenerController>().takePicture(),
                    child: const Icon(Icons.camera_alt)
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // 构建鼠标事件列表
  List<Widget> mouseEventListButton() {
    Map<String, String> mouseEventList = HashMap();
    mouseEventList.addIf(true, "left", "1");
    mouseEventList.addIf(true, "mid", "2");
    mouseEventList.addIf(true, "right", "3");
    mouseEventList.addIf(true, "up", "4");
    mouseEventList.addIf(true, "down", "5");
    List<Widget> widgets = [];
    mouseEventList.forEach((key, value) => widgets.add(
      ElevatedButton(
        onPressed: () => Get.find<ScreenshotController>().clickMouse(value), child: Text(key))
      )
    );
    return widgets;
  }
}
