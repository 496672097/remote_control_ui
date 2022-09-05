import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';
import 'package:remote_control_ui/common/model/tasksch.dart';

import '../model/command_model.dart';
class TaskschController{
  TextEditingController taskName = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController execPath = TextEditingController();

  void createTasksch() {
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        4,
        1,
        TaskSch(taskName.text, int.parse(duration.text), execPath.text).toJson());
    String json = commandModel.toJson();
    // print(commandModel.toJson());
    Get.find<SocketController>().send(json);
  }
}