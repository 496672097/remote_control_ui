import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';
import 'package:remote_control_ui/common/controller/source_manage_controller.dart';

import '../model/command_model.dart';

class ListenerController extends GetxController {
  String listenerLog = "";

  Uint8List bytes = Uint8List.fromList([]);

  // 键盘监听
  void keyListener() {
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        3,
        1,
        "keyborad");
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  // 鼠标监听
  // void mouseListener() {
  //   CommandModel commandModel = CommandModel(
  //       Get.find<SocketController>().target,
  //       Get.find<SocketController>().username.text,
  //       3,
  //       2,
  //       "mouse");
  //   String json = commandModel.toJson();
  //   Get.find<SocketController>().send(json);
  // }

  // 追加记录
  addLogger(CommandModel model) {
    String event =
        model.action == 1 ? '键盘事件：${model.data}\n' : "鼠标事件：${model.data}\n";
    listenerLog += event;
    update();
  }

  // 清空日志记录
  clear() {
    listenerLog = '';
    update();
  }

  // 截图
  getScreenshot() {
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        3,
        4,
        "screenshot");
    String json = commandModel.toJson();
    bytes = Uint8List.fromList([]);
    update();
    Get.find<SocketController>().transStatus = 2;
    Get.find<SocketController>().send(json);
  }
  // 获得照片
  takePicture() async{
    Get.find<SourceManageController>().downloadPath = await FilePicker.platform.getDirectoryPath();
    DateTime now = DateTime.now();
    Get.find<SourceManageController>().downloadFileName = "${ now.hour }-${ now.minute }-${ now.second }.png";

    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        3,
        7,
        "takePicture");
    String json = commandModel.toJson();
    Get.find<SocketController>().transStatus = 1;
    Get.find<SocketController>().send(json);
  }

  // 捕获摄像头拍取一张照片
  // catchPciture() {
  //   CommandModel commandModel = CommandModel(
  //       Get.find<SocketController>().target,
  //       Get.find<SocketController>().username.text,
  //       3,
  //       4,
  //       "capture");
  //   String json = commandModel.toJson();
  //   Get.find<SocketController>().send(json);
  // }
}
