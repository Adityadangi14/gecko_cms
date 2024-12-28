import 'package:gecko_cms/module/categories/controller/blog_category_controller.dart';
import 'package:gecko_cms/module/homescreen/controller/blog_controller.dart';
import 'package:gecko_cms/module/homescreen/controller/companyController.dart';
import 'package:gecko_cms/module/homescreen/controller/consoleController.dart';
import 'package:gecko_cms/module/homescreen/controller/homescreenController.dart';
import 'package:gecko_cms/module/homescreen/controller/tag_controller.dart';
import 'package:get/get.dart';

class Provider {
  static init() {
    Get.lazyPut(() => HomescreenController());
    Get.lazyPut(() => CompanyController());
    Get.lazyPut(() => TagController());
    Get.lazyPut(() => BlogController());
    Get.lazyPut(() => ConsoleController());
    Get.lazyPut(() => BlogCategoryController());
  }
}
