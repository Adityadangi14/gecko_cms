import 'package:gecko_cms/core/network/network.dart';
import 'package:gecko_cms/module/homescreen/model/company_model.dart';

class GetCompaniesService {
  Future<CompanyModel> getCompaniesServeice(String url) async {
    try {
      var response = await NetworkHelper.getData(url);
      if (response["success"]) {
        return CompanyModel.fromJson(response);
      } else {
        throw "unable to get company data";
      }
    } catch (e) {
      rethrow;
    }
  }
}
