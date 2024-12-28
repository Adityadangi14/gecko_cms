import 'package:gecko_cms/core/network/network.dart';
import 'package:gecko_cms/module/categories/model/blog_category_model.dart';

class BlogCategoryService {
  Future<BlogCategoryModel> getBlogCategories(String url) async {
    try {
      var response = await NetworkHelper.getData(url);
      if (response["success"]) {
        return BlogCategoryModel.fromJson(response);
      } else {
        throw "unable to get company data";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<BlogCategoryModel> createBlogCategory(
      String url, Map<String, dynamic> body) async {
    try {
      var response = await NetworkHelper.postData(url, body);
      if (response["success"]) {
        return BlogCategoryModel.fromJson(response);
      } else {
        throw "unable to get company data";
      }
    } catch (e) {
      rethrow;
    }
  }
}
