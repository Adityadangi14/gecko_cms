import 'dart:convert';

import 'package:gecko_cms/core/api-constants/api_constant.dart';
import 'package:gecko_cms/module/homescreen/model/company_model.dart';
import 'package:gecko_cms/module/homescreen/services/add_company.dart';
import 'package:gecko_cms/module/homescreen/services/get_comapnies.dart';
import 'package:get/state_manager.dart';

class HomescreenController extends GetxController {
  var currentScreen = AppScreen.company.obs;
}

enum AppScreen { company, blog, tags, categories, trending }
