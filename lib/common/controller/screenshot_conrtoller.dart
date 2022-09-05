import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';
import 'package:remote_control_ui/common/model/mouse_location.dart';

import '../model/command_model.dart';

class ScreenshotController extends GetxController {
  // x轴
  TextEditingController x = TextEditingController();
  // y轴
  TextEditingController y = TextEditingController();

  // 字符串序列
  TextEditingController sequence = TextEditingController();

  // 鼠标移动
  moveMouse() {
    String data = MouseLocation(int.parse(x.text), int.parse(y.text)).toJson();
    CommandModel commandModel = CommandModel(
      Get.find<SocketController>().target,
      Get.find<SocketController>().username.text,
      3,
      5,
      data
    );
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  // 鼠标点击
  clickMouse(String action){
    CommandModel commandModel = CommandModel(
      Get.find<SocketController>().target,
      Get.find<SocketController>().username.text,
      3,
      6,
      action
    );
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  // 单击键盘
  clickKeyboard(int keycode){
    CommandModel commandModel = CommandModel(
      Get.find<SocketController>().target,
      Get.find<SocketController>().username.text,
      3,
      5,
      keycode.toString()
    );
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  // 写入一串字符串
  writeKeySequence() {
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        3,
        8,
        sequence.text
    );
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

}
