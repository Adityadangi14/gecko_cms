import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/logging/console_log.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/consoleController.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Console extends StatelessWidget {
  Console({super.key});

  final ConsoleController consoleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Obx(() {
        return Container(
          color: AppColors.primaryBlack,
          height: (consoleController.height.value).h,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.terminal,
                          color: AppColors.white,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Console",
                          style: AppTextStyle.body_2
                              .copyWith(color: AppColors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              consoleController.consolelist.clear();
                            },
                            icon: Icon(Icons.remove)),
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              consoleController.height.value == 7
                                  ? consoleController.height.value = 30
                                  : consoleController.height.value = 7;
                            },
                            child: consoleController.height.value == 7
                                ? const Icon(
                                    Icons.arrow_drop_up_rounded,
                                    color: AppColors.white,
                                  )
                                : const Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: AppColors.white,
                                  ),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<ConsoleData>(
                    stream: ConsoleLog.consoleStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        consoleController.consolelist.add(snapshot.data!);
                        return Obx(() {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: consoleController.consolelist.length,
                            itemBuilder: (context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "=> ",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Expanded(
                                      child: SelectionArea(
                                          child: consoleController
                                              .consolelist[index].text)),
                                ],
                              );
                            },
                          );
                        });
                      } else {
                        return Container();
                      }
                    }),
              )
            ],
          ),
        );
      });
    });
  }
}
