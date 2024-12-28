import 'package:gecko_cms/core/network/network.dart';

class GetTrendingBlogsService {
  Future<Map<String, dynamic>> getTrendingBlogsService(
      {required String url}) async {
    try {
      var response = await NetworkHelper.getData(url);

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
