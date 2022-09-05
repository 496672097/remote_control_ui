import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocketController>(
      init: Get.find<SocketController>(),
      builder: (controller){
        return Container(
          color: BaseConstArgs().primaryColor,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: controller.messageList.map((e) =>
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${e.username}: ',
                                style: const TextStyle(color: Colors.lightGreen)
                              ),
                              TextSpan(
                                text: e.content,
                                style: const TextStyle(color: Colors.grey)
                              )
                            ]
                          ),
                        ),
                      )
                  ).toList(),
                ),
              ),
              TextField(
                controller: controller.message,
                onSubmitted: (msg) => controller.sendMessage(),
                style: TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                  labelStyle: const TextStyle(color: Colors.lightGreen),
                  label: Text("message"),
                  fillColor: const Color.fromRGBO(0, 80, 0, .3),
                  filled: true,
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.grey, width: 1)) : InputBorder.none,
                  // focusedBorder: const OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.lightGreen, width: 1)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
