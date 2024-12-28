import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/blog_controller.dart';
import 'package:gecko_cms/module/homescreen/controller/tag_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AvailiableTagsSection extends StatefulWidget {
  const AvailiableTagsSection({super.key});

  @override
  State<AvailiableTagsSection> createState() => _AvailiableTagsSectionState();
}

class _AvailiableTagsSectionState extends State<AvailiableTagsSection> {
  TagController tagController = Get.find();
  BlogController blogController = Get.find();

  final TextEditingController _tagController = TextEditingController();

  @override
  void initState() {
    if (tagController.tagsModel.value.tags == null) {
      tagController.getTags();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    blogController.selectedTags.value = [];

    blogController.croppedImage.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Available Tags",
                style: AppTextStyle.head_4,
              ),
              IconButton(
                  onPressed: () {
                    tagController.showAddTagField.value = true;
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  ))
            ],
          ),
          Obx(() {
            return tagController.showAddTagField.value
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
                    child: TextFormField(
                      controller: _tagController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tag Name can't be empty";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.link),
                          hintText: '',
                          suffix: IconButton(
                              onPressed: () async {
                                if (_tagController.text.trim() != "") {
                                  await tagController.addTag(
                                      {"Tag": _tagController.text.trim()});
                                  tagController.showAddTagField.value = false;
                                } else {
                                  Get.snackbar(
                                      "Error", "Tag Name can't be empty");
                                }
                              },
                              icon: const Icon(CupertinoIcons.paperplane_fill)),
                          labelText: 'Tag Name'),
                    ),
                  )
                : Container();
          }),
          SizedBox(
            height: 5.h,
          ),
          Obx(() {
            return tagController.isLoading.value
                ? const CircularProgressIndicator()
                : Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: tagController.tagsModel.value.tags!
                        .map((e) => FilterChip(
                              backgroundColor: blogController.selectedTags.value
                                      .contains(e.id)
                                  ? AppColors.primaryBlack
                                  : AppColors.white,
                              shape: const StadiumBorder(
                                  side: BorderSide(width: 1.5)),
                              label: Text(
                                e.tagName ?? "",
                                style: AppTextStyle.CTA.copyWith(
                                    color: blogController.selectedTags.value
                                            .contains(e.id)
                                        ? AppColors.white
                                        : AppColors.primaryBlack),
                              ),
                              onSelected: (value) {
                                blogController.selectedTags.value.contains(e.id)
                                    ? blogController.selectedTags.value
                                        .remove(e.id)
                                    : blogController.selectedTags.value
                                        .add(e.id!);

                                setState(() {});
                              },
                            ))
                        .toList(),
                  );
          }),
        ],
      ),
    );
  }
}
