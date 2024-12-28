import 'package:gecko_cms/core/network/network.dart';
import 'package:gecko_cms/module/homescreen/model/company_model.dart';

class AddCompanyService {
  Future<CompanyModel> addCompanyService(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      var response = await NetworkHelper.postData(url, body);

      if (response["success"]) {
        return CompanyModel.fromJson(response);
      } else {
        throw "Unable to add company";
      }
    } catch (e) {
      throw (e);
    }
  }
}
