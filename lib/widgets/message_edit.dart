import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';

class MessageEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: Get.find<SocketController>().message,
              onSubmitted: (message) => Get.find<SocketController>().sendMessage(),
            )
          ),
          ElevatedButton.icon(
            onPressed: () => Get.find<SocketController>().sendMessage(),
            icon: const Icon(Icons.send),
            label: const Text('发送')
          )
        ],
      ),
    );
  }
}
