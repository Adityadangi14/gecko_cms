import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/blog_controller.dart';
import 'package:gecko_cms/module/homescreen/model/blog_model.dart';
import 'package:get/get.dart';

class BlogContainer extends StatelessWidget {
  const BlogContainer({super.key, required this.blogData});

  final BlogData blogData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            fit: BoxFit.fitWidth,
            image: NetworkImage(blogData.thumbnailUrl!),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.primaryBlack.withOpacity(0.6),
                      AppColors.primaryBlack.withOpacity(0.4),
                      AppColors.primaryBlack.withOpacity(0.2),
                      AppColors.primaryBlack.withOpacity(0.0),
                    ])),
            child: Text(
              blogData.title!,
              style: AppTextStyle.head_4.copyWith(color: AppColors.white),
              maxLines: 3,
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryBlack.withOpacity(0.4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                        blogData.company!.companyLogoURL!,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${blogData.company!.companyName}",
                    style: AppTextStyle.CTA.copyWith(color: AppColors.white),
                  ),
                ],
              )),
        ),
        Positioned(
            right: 10,
            child: BlogContainerDropDown(
              blogId: blogData.iD ?? 0,
            ))
      ]),
    );
  }
}

class BlogContainerDropDown extends StatelessWidget {
  BlogContainerDropDown({super.key, required this.blogId});
  final BlogController blogController = Get.find();
  final int blogId;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        blogController.addBlogToTrending(blogId);
      },
      color: Colors.white,
      iconColor: Colors.white,
      itemBuilder: (context) {
        return <PopupMenuItem>[
          const PopupMenuItem<String>(
            value: "Trending",
            child: Text("Mark Trending"),
          ),
        ];
      },
    );
  }
}
