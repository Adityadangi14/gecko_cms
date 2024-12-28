import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/categories/controller/blog_category_controller.dart';
import 'package:gecko_cms/module/homescreen/controller/tag_controller.dart';
import 'package:gecko_cms/widget-constants/button/app_button.dart';
import 'package:gecko_cms/widget-constants/button/button_loading_animation.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BlogCategoriesScreen extends StatefulWidget {
  const BlogCategoriesScreen({super.key});

  @override
  State<BlogCategoriesScreen> createState() => _BlogCategoriesScreenState();
}

class _BlogCategoriesScreenState extends State<BlogCategoriesScreen> {
  final TagController tagController = Get.find();
  final BlogCategoryController blogCategoryController = Get.find();

  final TextEditingController catNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    if (tagController.tagsModel.value.tags == null) {
      tagController.getTags();
    }
    if (blogCategoryController.blogCategoryModel.value.data == null) {
      blogCategoryController.getBlogCategories();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Add Category",
                    style: AppTextStyle.head_4,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: catNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category Name can\'t be empty';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                            CupertinoIcons.square_line_vertical_square_fill),
                        hintText: 'System Design',
                        labelText: 'Category Name *'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppButton(
                    onPressed: () async {
                      await blogCategoryController.createBlogCategory({
                        "CategoryName": catNameController.text.trim(),
                        "TagIds":
                            blogCategoryController.selectedCategories.value
                      });

                      blogCategoryController.selectedCategories.value = [];
                      catNameController.text = "";
                    },
                    child: Text(
                      "Add",
                      style: AppTextStyle.CTA.copyWith(color: AppColors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Categories", style: AppTextStyle.head_4),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return blogCategoryController.isLoading.value
                        ? const ButtonLoadingAnimation()
                        : Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: blogCategoryController
                                .blogCategoryModel.value.data!
                                .map((e) => FilterChip(
                                      backgroundColor: AppColors.primaryBlack,
                                      shape: const StadiumBorder(
                                          side: BorderSide(width: 1.5)),
                                      label: Text(
                                        e.categoryName!,
                                        style: AppTextStyle.body_1_med
                                            .copyWith(color: AppColors.white),
                                      ),
                                      onSelected: (value) {},
                                    ))
                                .toList(),
                          );
                  })
                ],
              ),
            ),
            const VerticalDivider(),
            Obx(() {
              return tagController.isLoading.value
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Available Tags",
                            style: AppTextStyle.head_4,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: tagController.tagsModel.value.tags!
                                .map((e) => FilterChip(
                                      backgroundColor: blogCategoryController
                                              .selectedCategories
                                              .contains(e.id!)
                                          ? AppColors.primaryBlack
                                          : AppColors.white,
                                      shape: const StadiumBorder(
                                          side: BorderSide(width: 1.5)),
                                      label: Text(
                                        e.tagName!,
                                        style: TextStyle(
                                            color: blogCategoryController
                                                    .selectedCategories
                                                    .contains(e.id!)
                                                ? AppColors.white
                                                : AppColors.primaryBlack),
                                      ),
                                      onSelected: (value) {
                                        blogCategoryController
                                                .selectedCategories
                                                .contains(e.id!)
                                            ? blogCategoryController
                                                .selectedCategories.value
                                                .remove(e.id!)
                                            : blogCategoryController
                                                .selectedCategories.value
                                                .add(e.id!);
                                        setState(() {});
                                      },
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
