import 'dart:convert';
import 'dart:io';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:flutter/material.dart';

import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/blog_controller.dart';
import 'package:gecko_cms/module/homescreen/controller/companyController.dart';
import 'package:gecko_cms/module/homescreen/model/company_model.dart';
import 'package:gecko_cms/module/homescreen/services/crop_image_service.dart';
import 'package:gecko_cms/module/homescreen/services/image_picker_service.dart';
import 'package:gecko_cms/widget-constants/button/app_button.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:image/image.dart' as img;

class BlogFormSection extends StatelessWidget {
  BlogFormSection({super.key});

  final TextEditingController blogTitleController = TextEditingController();
  final TextEditingController blogDescriptionController =
      TextEditingController();
  final TextEditingController blogUrlController = TextEditingController();
  final ValueNotifier<TextEditingController> pubTimeController =
      ValueNotifier(TextEditingController());
  final CompanyController companyController = Get.find();

  final BlogController blogController = Get.find();
  final _formKey = GlobalKey<FormState>();

  Compaines? dropDownValue;

  String thumbnailUrl = "";

  BlurHash? blurhash;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () async {
                XFile? file = await ImagePickerService.pickImage();

                if (file != null && context.mounted) {
                  CroppedFile croppedFile =
                      await CropImageService.cropImages(file, context);

                  var fileToUpload = await croppedFile.readAsBytes();
                  print("Error check");

                  blurhash = BlurHash.encode(
                    img.decodeImage(fileToUpload)!,
                  );

                  thumbnailUrl =
                      await blogController.uploadThumbnail(fileToUpload);
                  blogController.croppedImage.value = croppedFile.path;
                }
              },
              child: AspectRatio(
                aspectRatio: 3 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.grey2),
                  ),
                  child: Obx(() {
                    return blogController.croppedImage.value == ""
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Pick Thumbnail",
                                style: AppTextStyle.CTA.copyWith(
                                  color: AppColors.grey2,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.image,
                                color: AppColors.grey2,
                              ),
                            ],
                          )
                        : Image(
                            image: NetworkImage(
                                blogController.croppedImage.value));
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: blogTitleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title can\'t be empty';
                }

                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  hintText: '',
                  labelText: 'Title'),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: blogDescriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description can\'t be empty';
                }

                return null;
              },
              keyboardType: TextInputType.emailAddress,
              maxLines: 3,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  hintText: '',
                  labelText: 'Discription'),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: blogUrlController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  try {
                    final uri = Uri.tryParse(value!);
                    if (uri != null &&
                        uri.scheme.isNotEmpty &&
                        (uri.scheme == 'http' || uri.scheme == 'https')) {
                      return null;
                    } else {
                      return "Enter a valid url";
                    }
                  } catch (e) {
                    return "Enter a valid url";
                  }
                }

                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.link),
                  hintText: '',
                  labelText: 'Blog url'),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: pubTimeController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Pub time can't be empty";
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.link),
                        hintText: '',
                        labelText: 'Pub Time'),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ValueListenableBuilder(
                  valueListenable: pubTimeController.value,
                  builder: (context, value, child) {
                    return pubTimeController.value.text.trim() != ""
                        ? Text(
                            DateFormat('yyyy-MM-dd')
                                .format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(pubTimeController.value.text),
                                  ),
                                )
                                .toString(),
                            style: AppTextStyle.caption
                                .copyWith(fontStyle: FontStyle.italic),
                          )
                        : Container();
                  },
                ),
                IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        pubTimeController.value.text =
                            pickedDate.millisecondsSinceEpoch.toString();
                      }
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(() {
              if (companyController.companyModel.value.compaines != null) {
                dropDownValue =
                    companyController.companyModel.value.compaines!.first;
              }
              return companyController.isCompaniesLoading.value
                  ? const CircularProgressIndicator()
                  : DropdownButtonFormField(
                      hint: const Text("Select company"),
                      value: dropDownValue,
                      items: companyController.companyModel.value.compaines!
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        e.companyLogo!,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(e.company!),
                                ],
                              )))
                          .toList(),
                      onChanged: (value) {
                        dropDownValue = value!;
                      },
                    );
            }),
            SizedBox(
              height: 2.h,
            ),
            Obx(() {
              return AppButton(
                  onPressed: () async {
                    if (thumbnailUrl == "") {
                      Get.snackbar("Error", "Thumbnail Url is empty");
                    } else if (_formKey.currentState!.validate()) {
                      await blogController.createBlogController({
                        "Title": blogTitleController.text,
                        "ThumbnailUrl": thumbnailUrl,
                        "Discription": blogDescriptionController.text,
                        "PubTime": pubTimeController.value.text,
                        "BlogUrl": blogUrlController.text,
                        "CompanyId": dropDownValue!.id,
                        "TagsId": blogController.selectedTags,
                        "ThumbnailBlurhash":
                            blurhash != null ? blurhash!.hash : ""
                      });

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  buttonState: blogController.isLoading.value
                      ? ButtonState.loading
                      : ButtonState.active,
                  child: Text(
                    "Create Blog",
                    style: AppTextStyle.CTA.copyWith(color: AppColors.white),
                  ));
            }),
          ],
        ),
      ),
    );
  }
}
