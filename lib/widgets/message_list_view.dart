import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';
import 'package:remote_control_ui/common/model/message_model.dart';

class MessageListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocketController>(
      init: Get.find<SocketController>(),
      builder: (controller) {
        return ListView(
          children: controller.messageList.map((e) => e.username == controller.username.text ? myMsg(e) : otherMsg(e)).toList(),
        );
      },
    );
  }

  Widget otherMsg(MessageModel msg) {
    return Text('${msg.username}==>${msg.content}');
  }

  Widget myMsg(MessageModel msg) {
    return Text('${msg.username}==>${msg.content}');
  }
}
