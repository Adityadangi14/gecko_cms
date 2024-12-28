import 'package:flutter/material.dart';
import 'package:gecko_cms/module/categories/screen/blog_categories.dart';
import 'package:gecko_cms/module/homescreen/controller/homescreenController.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-blog/add_blog.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-company/add_company.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-tags/add_tags.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/console.dart';
import 'package:gecko_cms/module/trending/screen/trending_blogs_screen.dart';
import 'package:get/get.dart';

class FieldPanel extends StatelessWidget {
  FieldPanel({super.key});

  final HomescreenController homescreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Obx(() {
          return getScreen(homescreenController);
        })),
        Console()
      ],
    );
  }
}

Widget getScreen(HomescreenController homescreenController) {
  if (homescreenController.currentScreen.value == AppScreen.blog) {
    return const AddBlog();
  } else if (homescreenController.currentScreen.value == AppScreen.tags) {
    return const AddTagsScreen();
  } else if (homescreenController.currentScreen.value == AppScreen.categories) {
    return const BlogCategoriesScreen();
  } else if (homescreenController.currentScreen.value == AppScreen.trending) {
    return const TrendingBlogScreen();
  }

  return const CompanyWidget();
}
