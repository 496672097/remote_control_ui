import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/const/widget_style.dart';
import 'package:remote_control_ui/common/controller/listener_controller.dart';

class DeviceAbout extends StatelessWidget {
  const DeviceAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ListenerController());

    return Column(
      children: [
        Expanded(
          child: GetBuilder<ListenerController>(
            init: Get.find<ListenerController>(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Text(controller.listenerLog, style: WidgetStyle().defaultStyle),
              );
            },
          ),
        ),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () => Get.find<ListenerController>().keyListener(),
                  child: const Text('键盘记录')),
              // ElevatedButton(
              //     onPressed: () =>
              //         Get.find<ListenerController>().mouseListener(),
              //     child: const Text('鼠标监听')),
              ElevatedButton(
                  onPressed: () => Get.find<ListenerController>().clear(),
                  child: const Text('清空记录')),
            ],
          ),
        )
      ],
    );
  }
}
