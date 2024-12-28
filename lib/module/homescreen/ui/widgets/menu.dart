import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gecko_cms/module/homescreen/controller/homescreenController.dart';
import 'package:gecko_cms/widget-constants/menu_chip.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Menu extends StatelessWidget {
  Menu({super.key});
  final HomescreenController homescreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Colors.grey[200],
        height: 100.h,
        width: 15.w,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
            onTap: () =>
                homescreenController.currentScreen.value = AppScreen.company,
            child: MenuChip(
                icon: const Icon(CupertinoIcons.building_2_fill),
                title: "Company",
                selected: homescreenController.currentScreen.value ==
                    AppScreen.company),
          ),
          InkWell(
            onTap: () =>
                homescreenController.currentScreen.value = AppScreen.blog,
            child: MenuChip(
                icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                title: "Blog",
                selected:
                    homescreenController.currentScreen.value == AppScreen.blog),
          ),
          InkWell(
              onTap: () =>
                  homescreenController.currentScreen.value = AppScreen.tags,
              child: MenuChip(
                  icon: const Icon(CupertinoIcons.tag),
                  title: "Tags",
                  selected: homescreenController.currentScreen.value ==
                      AppScreen.tags)),
          InkWell(
            onTap: () =>
                homescreenController.currentScreen.value = AppScreen.categories,
            child: MenuChip(
                icon:
                    const Icon(CupertinoIcons.square_line_vertical_square_fill),
                title: "Categories",
                selected: homescreenController.currentScreen.value ==
                    AppScreen.categories),
          ),
          InkWell(
            onTap: () =>
                homescreenController.currentScreen.value = AppScreen.trending,
            child: MenuChip(
                icon: const Icon(Icons.trending_up_outlined),
                title: "Trending",
                selected: homescreenController.currentScreen.value ==
                    AppScreen.trending),
          ),
        ]),
      );
    });
  }
}
