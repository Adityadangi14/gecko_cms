import 'package:flutter/material.dart';
import 'package:gecko_cms/module/homescreen/controller/tag_controller.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-tags/widgets/add_tag_section.dart';
import 'package:gecko_cms/module/homescreen/ui/widgets/add-tags/widgets/available_tags.dart';
import 'package:get/get.dart';

class AddTagsScreen extends StatefulWidget {
  const AddTagsScreen({super.key});

  @override
  State<AddTagsScreen> createState() => _AddTagsScreenState();
}

class _AddTagsScreenState extends State<AddTagsScreen> {
  TagController tagController = Get.find();
  @override
  void initState() {
    tagController.getTags();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(flex: 1, child: AddTagSection()),
          VerticalDivider(),
          Flexible(flex: 2, child: AvailableTagsSection())
        ],
      ),
    );
  }
}
