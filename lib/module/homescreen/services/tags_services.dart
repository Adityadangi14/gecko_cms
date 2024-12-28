import 'package:gecko_cms/core/network/network.dart';

class TagsServices {
  Future<Map<String, dynamic>> getTagsService(String url) async {
    try {
      var res = await NetworkHelper.getData(url);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteTagService(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      var res = NetworkHelper.deleteData(endpoint: url, body: body);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> editTagService(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      var res = NetworkHelper.putData(endpoint: url, body: body);

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> addTagService(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      var res = NetworkHelper.postData(url, body);

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
