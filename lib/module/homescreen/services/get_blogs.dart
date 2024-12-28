import 'package:gecko_cms/core/network/network.dart';
import 'package:gecko_cms/module/homescreen/model/blog_model.dart';

class GetBlogsService {
  Future<BlogModel> getBlogsServeice(String url) async {
    try {
      var response = await NetworkHelper.getData(url);
      if (response["success"]) {
        return BlogModel.fromJson(response);
      } else {
        throw "unable to get company data";
      }
    } catch (e) {
      rethrow;
    }
  }
}
