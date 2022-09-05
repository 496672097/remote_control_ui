import 'package:flutter/material.dart';
import 'package:remote_control_ui/common/widget_model/nav_item_model.dart';

class WidgetConstArg{
  List navList = [
    NavItemModel(const Icon(Icons.keyboard), '命令执行', 0),
    NavItemModel(const Icon(Icons.device_hub), '硬件控制', 1),
    NavItemModel(const Icon(Icons.source), '资源管理', 2),
    NavItemModel(const Icon(Icons.usb), '键鼠记录', 3),
    NavItemModel(const Icon(Icons.add_box), '其他工具', 4)
    // NavItemModel(const Icon(Icons.message), '消息'),
  ];
}