import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';
import 'package:remote_control_ui/common/controller/tasksch_controller.dart';
import 'package:remote_control_ui/pages/nav_page.dart';
// import 'package:remote_control_ui/common/const/base_const_args.dart';

class OtherUtilPage extends StatelessWidget {
  const OtherUtilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TaskschController());

    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 4,
        runSpacing: 6,
        children: [
          InkWell(
            child: Container(
              height: 50,
              width: 140,
              color: Colors.lightGreen,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.edit_note),
                  Text('添加计划任务')
                ],
              ),
            ),
            onTap: () => Get.bottomSheet(
              Container(
                child: Column(
                  children: [
                    Container(
                      width: BaseConstArgs().isDeskTop ? 800 : double.infinity,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.lightGreen,
                        controller: Get.find<TaskschController>().taskName,
                        decoration: NavPage().defaultInputDecoration('计划任务名', Icons.lock_clock_outlined),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: BaseConstArgs().isDeskTop ? 800 : double.infinity,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.lightGreen,
                        controller: Get.find<TaskschController>().duration,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: NavPage().defaultInputDecoration('执行间隔时间', Icons.lock_clock_outlined),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: BaseConstArgs().isDeskTop ? 800 : double.infinity,
                      child: TextField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.lightGreen,
                          controller: Get.find<TaskschController>().execPath,
                          decoration: NavPage().defaultInputDecoration('执行路径', Icons.lock_clock_outlined)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: BaseConstArgs().isDeskTop ? 800 : double.infinity,
                      color: BaseConstArgs().primaryColor,
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white,),
                        onPressed: () => Get.find<TaskschController>().createTasksch(),
                      ),
                    )
                  ],
                ),
                height: 400,
                color: Colors.grey,
              )
            ),
          )
        ],
      ),
    );
  }
}
