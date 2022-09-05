import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/const/font_enum.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';

class MobileHome extends StatelessWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SocketController>(
        init: Get.find<SocketController>(),
        builder: (controller) {
          return controller.onlineList.isNotEmpty ?
          ListView(
            children: controller.onlineList.map((e) => InkWell(
              onTap: (){
                controller.target = e.ip;
                Get.toNamed('/menuPage');
              },
              child: Container(
                color: Colors.red,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FontEnum().map[e.os]!,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(e.ip),
                        Text(e.os),
                      ],
                    )
                  ],
                ),
              ),
            )).toList(),
          )
          : const Center(child: Text('请先连接到服务器!'));
        },
      ),
    );
  }
}
