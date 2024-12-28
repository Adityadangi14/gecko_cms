import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gecko_cms/module/homescreen/controller/homescreenController.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-blog/add_blog.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/field_panel.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/menu.dart';
import 'package:gecko_cms/widget-constants/menu_chip.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomescreenController homescreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [Menu(), Expanded(child: FieldPanel())],
      ),
    );
  }
}
