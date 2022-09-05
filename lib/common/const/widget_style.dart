import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';

class WidgetStyle{

  TextStyle defaultStyle = BaseConstArgs().isDeskTop ?
          TextStyle(fontSize: 18, color: Colors.grey) :
          TextStyle(fontSize: 14);

  Color defaultColor = BaseConstArgs().isDeskTop ? Colors.grey : Colors.white;

}