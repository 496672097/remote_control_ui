import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/const/widget_style.dart';
import 'package:remote_control_ui/common/controller/cmd_exec_controller.dart';

class CommandExecutionPage extends StatelessWidget {
  const CommandExecutionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CommandExecutionController());

    return GetBuilder<CommandExecutionController>(
      init: Get.find<CommandExecutionController>(),
      builder: (controller){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(controller.result, style: WidgetStyle().defaultStyle),
              ),
            ),
            TextField(
              controller: controller.exec,
              onSubmitted: (cmd) => controller.execution(cmd),
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
        );
      }
    );
  }
}
