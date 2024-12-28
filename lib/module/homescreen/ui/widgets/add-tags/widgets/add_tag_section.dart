import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/tag_controller.dart';
import 'package:gecko_cms/widget-constants/button/app_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddTagSection extends StatelessWidget {
  AddTagSection({super.key});

  final TextEditingController tagTextController = TextEditingController();

  final TagController tagController = TagController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Add Tag",
            style: AppTextStyle.head_4,
          ),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: tagTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tag name can\'t be empty';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.tag),
                          hintText: 'Backend Development',
                          labelText: 'Tag Name'),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Obx(() {
                      return AppButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await tagController.addTag(
                                  {"Tag": tagTextController.text.trim()});
                            }
                          },
                          buttonState: tagController.isLoading.value
                              ? ButtonState.loading
                              : ButtonState.active,
                          child: Text(
                            "Continue",
                            style: AppTextStyle.CTA
                                .copyWith(color: AppColors.white),
                          ));
                    })
                  ],
                )),
          )
        ],
      ),
    );
  }
}
