import 'package:gecko_cms/core/network/network.dart';

class AddTrendingBlogService {
  Future<Map<String, dynamic>> addTrendingBlogService(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      var response = await NetworkHelper.postData(url, body);

      if (response["success"] == true) {
        return response;
      } else {
        throw ("Unable to add trending blogs.");
      }
    } catch (e) {
      rethrow;
    }
  }
}
