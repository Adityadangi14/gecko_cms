import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/blog_controller.dart';
import 'package:gecko_cms/widget-constants/button/app_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TrendingBlogScreen extends StatefulWidget {
  const TrendingBlogScreen({super.key});

  @override
  State<TrendingBlogScreen> createState() => _TrendingBlogScreenState();
}

class _TrendingBlogScreenState extends State<TrendingBlogScreen> {
  final BlogController _blogController = Get.find();
  @override
  void initState() {
    // TODO: implement initState

    _blogController.getTrendingBlogs();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _blogController.error.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_blogController.error.value != "") {
          return Text(_blogController.error.value);
        }
        return _blogController.isTrendingBlogLoading.value
            ? const CircularProgressIndicator()
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: _blogController.trendingBlogs.value.data!.length,
                itemBuilder: (context, index) {
                  final blog = _blogController.trendingBlogs.value.data![index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 50.w,
                        height: 150,
                        child: Card(
                          child: Row(
                            children: [
                              Image.network(blog.thumbnailUrl ?? ""),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Title: ${blog.title ?? ""}")
                                  ],
                                ),
                              ),
                              AppButton(
                                  onPressed: () {
                                    _blogController
                                        .removeTrendingBlog(blog.iD ?? 0);
                                  },
                                  child: Text(
                                    "Remove from trending",
                                    style: AppTextStyle.CTA
                                        .copyWith(color: AppColors.white),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
      }),
    );
  }
}
