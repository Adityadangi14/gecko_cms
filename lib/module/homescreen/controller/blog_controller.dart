import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:gecko_cms/core/api-constants/api_constant.dart';
import 'package:gecko_cms/core/network/network.dart';
import 'package:gecko_cms/module/homescreen/model/blog_model.dart';
import 'package:gecko_cms/module/homescreen/services/add_trending_blog_service.dart';
import 'package:gecko_cms/module/homescreen/services/create_blog_service.dart';
import 'package:gecko_cms/module/homescreen/services/get_blogs.dart';
import 'package:gecko_cms/module/homescreen/services/get_trending_blog_service.dart';
import 'package:gecko_cms/module/homescreen/services/remove_from_trending.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  var selectedTags = <int>[].obs;

  var croppedImage = ''.obs;

  var isLoading = false.obs;
  var isLoadingMoreBlogs = false.obs;
  var isTrendingBlogLoading = false.obs;

  var error = ''.obs;

  var blogModel = BlogModel().obs;

  var trendingBlogs = BlogModel().obs;

  int pageNo = 1;

  final CreateBlogService createBlogService = CreateBlogService();
  final GetBlogsService getBlogsService = GetBlogsService();
  final AddTrendingBlogService _addTrendingBlogService =
      AddTrendingBlogService();

  final GetTrendingBlogsService _getTrendingBlogsService =
      GetTrendingBlogsService();
  final RemoveFromTrending _removeFromTrending = RemoveFromTrending();

  Future<void> getBlogController() async {
    pageNo == 1 ? isLoading(true) : isLoadingMoreBlogs(true);
    try {
      BlogModel data = await getBlogsService.getBlogsServeice(
          "${ApiConstant.apiConstant}/getBlogs?pageNo=$pageNo");
      if (data.success == true) {
        if (pageNo <= 1) {
          blogModel.value = data;
        } else {
          blogModel.value.data!.addAll(data.data!);
          blogModel.refresh();
        }
      } else {
        error.value = "Unable to create blog";
      }
    } catch (e) {
      error.value = "Unable to create blog";
    }
    print(blogModel.value.data!.length);
    pageNo == 1 ? isLoading(false) : isLoadingMoreBlogs(false);
  }

  Future<void> createBlogController(Map<String, dynamic> body) async {
    isLoading(true);
    try {
      BlogModel data = await createBlogService.createBlogService(
          url: "${ApiConstant.apiConstant}/createBlog", body: body);
      if (data.success == true) {
        blogModel.value = data;
      } else {
        error.value = "Unable to create blog";
      }
    } catch (e) {
      error.value = "Unable to create blog";
    }
    isLoading(false);
  }

  Future<String> uploadThumbnail(Uint8List file) async {
    try {
      Map<String, dynamic> data = await NetworkHelper.uploadImage(
          file, "${ApiConstant.apiConstant}/uploadThumblanilFile");

      if (data["success"]) {
        return data["url"];
      } else {
        throw ("unable to upload image");
      }
    } catch (e) {
      throw ("unable to upload image");
    }
  }

  Future<void> addBlogToTrending(int blogId) async {
    try {
      Map<String, dynamic> res = await _addTrendingBlogService
          .addTrendingBlogService(
              url: "${ApiConstant.apiConstant}/addTrendingBlog",
              body: {"BlogId": blogId});

      trendingBlogs.value = BlogModel.fromJson(res);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> getTrendingBlogs() async {
    isTrendingBlogLoading(true);
    try {
      Map<String, dynamic> res =
          await _getTrendingBlogsService.getTrendingBlogsService(
              url: "${ApiConstant.apiConstant}/getTrendingBlogs");

      trendingBlogs.value = BlogModel.fromJson(res);
    } catch (e) {
      error.value = e.toString();
      throw (e);
    } finally {
      isTrendingBlogLoading(false);
    }
  }

  Future<void> removeTrendingBlog(int blogId) async {
    isTrendingBlogLoading(true);
    try {
      Map<String, dynamic> res = await _removeFromTrending.removeTrendingBlog(
          url: "${ApiConstant.apiConstant}/deleteTrendingBlog",
          body: {
            "BlogId": blogId,
          });

      trendingBlogs.value = BlogModel.fromJson(res);
    } catch (e) {
      error.value = e.toString();
      throw (e);
    } finally {
      isTrendingBlogLoading(false);
    }
  }
}
