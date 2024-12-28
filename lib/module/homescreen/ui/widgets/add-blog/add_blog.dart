import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/logging/console_log.dart';
import 'package:gecko_cms/module/homescreen/controller/blog_controller.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-blog/widgets/add_blog_dialog.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-blog/widgets/blog_container.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final BlogController blogController = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    blogController.getBlogController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() async {
        if (scrollController.position.maxScrollExtent ==
                scrollController.position.pixels &&
            blogController.isLoadingMoreBlogs.value == false &&
            blogController.blogModel.value.isNextPageExist == true) {
          blogController.pageNo = blogController.pageNo + 1;
          blogController.getBlogController();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    blogController.pageNo = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlack,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddBlogSection(),
          );
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: Obx(() {
        return blogController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  GridView.builder(
                    controller: scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    itemCount: blogController.blogModel.value.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 16 / 9),
                    itemBuilder: (context, index) {
                      return BlogContainer(
                          blogData:
                              blogController.blogModel.value.data![index]);
                    },
                  ),
                  Positioned(
                      bottom: 0,
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Obx(() {
                        ConsoleLog.consoleStream
                            .add(ConsoleData(LogType.error, Text("${0}")));
                        return blogController.isLoadingMoreBlogs.value
                            ? const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              )
                            : Container();
                      }))
                ],
              );
      }),
    );
  }
}
