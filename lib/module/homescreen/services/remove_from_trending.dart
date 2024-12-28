import 'package:gecko_cms/core/network/network.dart';

class RemoveFromTrending {
  Future<Map<String, dynamic>> removeTrendingBlog(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      var response = await NetworkHelper.deleteData(body: body, endpoint: url);

      if (response["success"] == true) {
        return response;
      } else {
        throw ("Unable to get trending blogs.");
      }
    } catch (e) {
      rethrow;
    }
  }
}
