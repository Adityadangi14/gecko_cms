import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-blog/widgets/available_tags_sction.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-blog/widgets/blog_form_section.dart';
import 'package:sizer/sizer.dart';

class AddBlogSection extends StatelessWidget {
  const AddBlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Blog",
                    style: AppTextStyle.head_4,
                  ),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.clear,
                        size: 30,
                        color: AppColors.grey2,
                      ))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlogFormSection(),
                  SizedBox(height: 70.h, child: const VerticalDivider()),
                  const AvailiableTagsSection(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
