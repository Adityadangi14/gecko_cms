import 'package:gecko_cms/core/api-constants/api_constant.dart';
import 'package:gecko_cms/module/homescreen/model/company_model.dart';
import 'package:gecko_cms/module/homescreen/services/add_company.dart';
import 'package:gecko_cms/module/homescreen/services/delete_company.dart';
import 'package:gecko_cms/module/homescreen/services/edit_company.dart';
import 'package:gecko_cms/module/homescreen/services/get_comapnies.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  var isCompaniesLoading = false.obs;
  var isAddCompanyLoading = false.obs;

  var companyModel = CompanyModel().obs;

  final GetCompaniesService _getCompaniesService = GetCompaniesService();
  final AddCompanyService _addCompanyService = AddCompanyService();

  final EditCompanyService editCompanyService = EditCompanyService();
  final DeleteCompanyService deleteCompanyService = DeleteCompanyService();

  Future<void> getCompanies() async {
    isCompaniesLoading(true);
    CompanyModel response = await _getCompaniesService
        .getCompaniesServeice("${ApiConstant.apiConstant}/getCompanies");

    companyModel.value = response;

    isCompaniesLoading(false);
  }

  Future<void> addCompany(Map<String, dynamic> body) async {
    isCompaniesLoading(true);
    CompanyModel response = await _addCompanyService.addCompanyService(
        body: body, url: "${ApiConstant.apiConstant}/createCompany");

    companyModel.value = response;

    isCompaniesLoading(false);
  }

  Future<void> editCompay(Map<String, dynamic> body) async {
    isCompaniesLoading(true);
    CompanyModel response = await _addCompanyService.addCompanyService(
        body: body, url: "${ApiConstant.apiConstant}/editCompany");

    companyModel.value = response;

    isCompaniesLoading(false);
  }

  Future<void> deleteCompany(Map<String, dynamic> body) async {
    try {
      isCompaniesLoading(true);

      CompanyModel response = await deleteCompanyService.deleteCompanyService(
          body: body, url: "${ApiConstant.apiConstant}/deleteCompany");

      companyModel.value = response;

      isCompaniesLoading(false);
    } on Exception catch (e) {
      isCompaniesLoading(false);
    }
  }
}
