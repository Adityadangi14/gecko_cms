import 'package:flutter/material.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/tag_controller.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-tags/widgets/update_delete_tag.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AvailableTagsSection extends StatelessWidget {
  AvailableTagsSection({super.key});

  final TagController tagController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Available Tags",
            style: AppTextStyle.head_4,
          ),
          SizedBox(
            height: 5.h,
          ),
          Obx(() {
            return tagController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Wrap(
                    runSpacing: 2.h,
                    spacing: 2.h,
                    children: tagController.tagsModel.value.tags!
                        .map((e) => FilterChip(
                              shape: const StadiumBorder(
                                  side: BorderSide(width: 1.5)),
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(e.tagName!),
                                ],
                              ),
                              onSelected: (value) {
                                showDialog(
                                  context: context,
                                  builder: (context) => UpdateDeleteTag(
                                    tagName: e.tagName!,
                                    tagID: e.id.toString(),
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  );
          })
        ],
      ),
    );
  }
}
