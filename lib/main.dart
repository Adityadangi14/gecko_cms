import 'package:flutter/material.dart';
import 'package:gecko_cms/core/prefs/prefs.dart';
import 'package:gecko_cms/core/provider/provider.dart';
import 'package:gecko_cms/core/theme/app_theme.dart';
import 'package:gecko_cms/module/homescreen/ui/homescreeen.dart';
import 'package:gecko_cms/module/login/login.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  Prefs.init();

  Provider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
          title: 'Gecko CMS',
          theme: AppTheme.appTheme(context),
          home: HomeScreen());
    });
  }
}
