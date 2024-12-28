import 'package:gecko_cms/core/api-constants/api_constant.dart';
import 'package:gecko_cms/module/categories/model/blog_category_model.dart';
import 'package:gecko_cms/module/categories/services/blog_category_service.dart';
import 'package:get/get.dart';

class BlogCategoryController extends GetxController {
  var isLoading = false.obs;
  var blogCategoryModel = BlogCategoryModel().obs;

  var selectedCategories = <int>[].obs;

  final BlogCategoryService _blogCategoryService = BlogCategoryService();

  Future<void> getBlogCategories() async {
    isLoading(true);
    try {
      BlogCategoryModel blogCategory = await _blogCategoryService
          .getBlogCategories("${ApiConstant.apiConstant}/getBlogCategory");

      blogCategoryModel.value = blogCategory;
    } catch (e) {
      rethrow;
    }
    isLoading(false);
  }

  Future<void> createBlogCategory(Map<String, dynamic> body) async {
    isLoading(true);
    try {
      BlogCategoryModel blogCategory =
          await _blogCategoryService.createBlogCategory(
              "${ApiConstant.apiConstant}/addBlogCategory", body);

      blogCategoryModel.value = blogCategory;
    } catch (e) {
      rethrow;
    }
    isLoading(false);
  }
}
