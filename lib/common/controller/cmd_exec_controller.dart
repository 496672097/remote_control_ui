import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';
import 'package:remote_control_ui/common/model/command_model.dart';

class CommandExecutionController extends GetxController{

  TextEditingController exec = TextEditingController();

  String result = "你还没有执行";

  execution(String cmd) {
    CommandModel commandModel = CommandModel(
      Get.find<SocketController>().target,
      Get.find<SocketController>().username.text,
      1,
      0,
      cmd
    );
    String json = commandModel.toJson();
    Get.find<SocketController>().send(json);
  }

  updateExecutionResult(String result){
    print('result ==> ${result}');
    this.result = result;
    update();
  }

}