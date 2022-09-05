import 'package:flutter/material.dart';
import 'package:remote_control_ui/common/const/base_const_args.dart';
import 'package:remote_control_ui/pages/mobile/mobile_menu.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const MobileMenu(),
    );
  }
}
