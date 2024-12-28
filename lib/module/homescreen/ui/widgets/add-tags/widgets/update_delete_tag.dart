import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/tag_controller.dart';
import 'package:gecko_cms/widget-constants/button/app_button.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';

class UpdateDeleteTag extends StatelessWidget {
  UpdateDeleteTag({super.key, required this.tagName, required this.tagID});

  final String tagName;
  final String tagID;

  final TextEditingController tagTextController = TextEditingController();

  final TagController tagController = Get.find();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(CupertinoIcons.clear)),
                InkWell(
                  onTap: () async {
                    await tagController.deleteTag({"TagId": tagID});
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                      controller: tagTextController..text = tagName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tag Name can\'t be empty';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.link),
                          hintText: 'Backend Development',
                          labelText: 'Tag Name *'),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Obx(() {
                      return AppButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await tagController.editTag({
                                "TagId": tagID,
                                "TagName": tagTextController.text.trim(),
                              });

                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          buttonState: tagController.isLoading.value
                              ? ButtonState.loading
                              : ButtonState.active,
                          child: Text(
                            "Update",
                            style: AppTextStyle.CTA
                                .copyWith(color: AppColors.white),
                          ));
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
