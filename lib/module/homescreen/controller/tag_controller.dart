import 'package:gecko_cms/core/api-constants/api_constant.dart';
import 'package:gecko_cms/module/homescreen/model/tags_model.dart';
import 'package:gecko_cms/module/homescreen/services/tags_services.dart';
import 'package:get/get.dart';

class TagController extends GetxController {
  var isLoading = false.obs;

  var showAddTagField = false.obs;

  var error = "".obs;

  var tagsModel = TagsModel().obs;

  TagsServices tagsServices = TagsServices();

  Future<void> getTags() async {
    isLoading(true);
    try {
      Map<String, dynamic> res = await tagsServices
          .getTagsService("${ApiConstant.apiConstant}/getTags");
      if (res["success"]) {
        tagsModel.value = TagsModel.fromJson(res);
        tagsModel.refresh();
      } else {
        error.value = res["message"];
      }
    } catch (e) {
      error.value = "Something went wrong";
      rethrow;
    }
    isLoading(false);
  }

  Future<void> addTag(Map<String, dynamic> body) async {
    isLoading(true);
    try {
      Map<String, dynamic> res = await tagsServices.addTagService(
          url: "${ApiConstant.apiConstant}/createTag", body: body);
      if (res["success"]) {
        tagsModel.value = TagsModel.fromJson(res);
        tagsModel.refresh();
      } else {
        error.value = res["message"];
      }
    } catch (e) {
      error.value = "Something went wrong";
      rethrow;
    }
    isLoading(false);
  }

  Future<void> deleteTag(Map<String, dynamic> body) async {
    isLoading(true);
    try {
      Map<String, dynamic> res = await tagsServices.deleteTagService(
          url: "${ApiConstant.apiConstant}/deleteTag", body: body);
      if (res["success"]) {
        tagsModel.value = TagsModel.fromJson(res);
        tagsModel.refresh();
      } else {
        error.value = res["message"];
      }
    } catch (e) {
      error.value = "Something went wrong";
      rethrow;
    }
    isLoading(false);
  }

  Future<void> editTag(Map<String, dynamic> body) async {
    isLoading(true);
    try {
      Map<String, dynamic> res = await tagsServices.editTagService(
          url: "${ApiConstant.apiConstant}/editTag", body: body);
      if (res["success"]) {
        tagsModel.value = TagsModel.fromJson(res);
        tagsModel.refresh();
      } else {
        error.value = res["message"];
      }
    } catch (e) {
      error.value = "Something went wrong";
      rethrow;
    }
    isLoading(false);
  }
}
