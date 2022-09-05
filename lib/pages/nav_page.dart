import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';
import 'package:remote_control_ui/common/const/font_enum.dart';
import 'package:remote_control_ui/common/controller/args_controller.dart';
import 'package:remote_control_ui/common/controller/socket_controller.dart';

class NavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ArgsController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BaseConstArgs().isMobile ? Stack(
        children: [
          Container(
            color: Colors.black87,
          ),
          GetBuilder<SocketController>(
            init: Get.find<SocketController>(),
            builder: (controller) {
              return Get.find<SocketController>().connect ? list() : login(context);
            },
          )
        ],
      ) : desktopLogin(context)
    );
  }

  defaultInputDecoration(String text, IconData icon) {
    return InputDecoration(
      labelStyle: const TextStyle(color: Colors.grey),
      label: Text(text),
      fillColor: BaseConstArgs().primaryColor,
      filled: true,
      prefixIcon: Icon(icon, color: Colors.grey),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1)),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1)),
    );
  }

  Widget desktopLogin(BuildContext context){
    return Stack(
      children: [
        Container(
          color: BaseConstArgs().primaryColor,
          width: double.infinity,
          height: double.infinity,
        ),
        Column(
          children: [
            Platform.isWindows ?
            Container(
              color: BaseConstArgs().primaryColor,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("images/logo.png"),
                      Text('智能合约一键梭哈', style: TextStyle(color: Colors.white))
                    ],
                  ),
                  winodwsButtons(),
                ],
              ),
            )
                : const SizedBox(width: 0, height: 0),
            Expanded(child: Image.asset("images/login_top.jpg", fit: BoxFit.cover)),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    child: login(context),
                    flex: 4,
                  ),
                  Expanded(flex: 3, child: SizedBox()),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  // 登陆组件
  Widget login(BuildContext context){
    return Center(
      child: Container(
        height: 400,
        width: BaseConstArgs().isMobile ? MediaQuery.of(context).size.width - 40 : 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.lightGreen,
              controller: Get.find<SocketController>().server,
              decoration: defaultInputDecoration('服务器地址', Icons.link)
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.lightGreen,
              controller: Get.find<SocketController>().username,
              decoration: defaultInputDecoration('用户名', Icons.account_circle_outlined),
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.lightGreen,
              controller: Get.find<SocketController>().password,
              decoration: defaultInputDecoration('密钥', Icons.lock_clock_outlined),
              obscureText: true,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton.icon(
                onPressed: () => Get.find<SocketController>().tryConnect(),
                icon: const Icon(Icons.remove_red_eye_rounded, color: Colors.white),
                label: const Text('连接', style: TextStyle(color: Colors.white),),
                style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  side: const BorderSide(width: 1, color: Colors.white),
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  // 移动端展示
  Widget list(){
    return GetBuilder<SocketController>(
      init: Get.find<SocketController>(),
      builder: (controller) {
        return ListView(
          children: controller.onlineList.map((e) => InkWell(
            onTap: (){
              Get.find<SocketController>().target = e.ip;
              Get.find<ArgsController>().checkTargetOS(e.os);
              // change select target os
              Get.find<ArgsController>().setTargetOs(e.os);
              // 如果是移动端则跳转
              if(BaseConstArgs().isMobile){
                Get.toNamed('/menuPage');
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen, width: 1)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FontEnum().map[e.os]!,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ip: ${e.ip}', style: const TextStyle(color: Colors.lightGreen)),
                      Text('hostname: ${e.hostname}', style: const TextStyle(color: Colors.lightGreen)),
                      Text('cpu: ${e.cpuCore}', style: const TextStyle(color: Colors.lightGreen))
                    ],
                  ),
                  IconButton(
                    onPressed: () => Get.find<SocketController>().closeConnect(e.ip),
                    icon: const Icon(Icons.signal_wifi_connected_no_internet_4, color: Colors.lightGreen,)
                  )
                ],
              ),
            ),
          )).toList(),
        );
      },
    );
  }

  Widget winodwsButtons() {
    return Row(
      children: [
        MinimizeWindowButton(colors: WindowButtonColors(
            iconNormal: const Color(0xFF805306),
            mouseOver: const Color(0xFFF6A00C),
            mouseDown: const Color(0xFF805306),
            iconMouseOver: const Color(0xFF805306),
            iconMouseDown: const Color(0xFFFFD500))),
        MaximizeWindowButton(colors: WindowButtonColors(
            iconNormal: const Color(0xFF805306),
            mouseOver: const Color(0xFFF6A00C),
            mouseDown: const Color(0xFF805306),
            iconMouseOver: const Color(0xFF805306),
            iconMouseDown: const Color(0xFFFFD500))),
        CloseWindowButton(colors: WindowButtonColors(
            iconNormal: const Color(0xFF805306),
            mouseOver: const Color(0xFFF6A00C),
            mouseDown: const Color(0xFF805306),
            iconMouseOver: const Color(0xFF805306),
            iconMouseDown: const Color(0xFFFFD500)))
      ],
    );
  }
}
