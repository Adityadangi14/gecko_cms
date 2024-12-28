import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';
import 'package:gecko_cms/module/homescreen/controller/companyController.dart';
import 'package:gecko_cms/widget-constants/button/app_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddCompanySection(),
        const VerticalDivider(),
        const Expanded(child: AvaildableCompaniesScection())
      ],
    );
  }
}

class AddCompanySection extends StatelessWidget {
  AddCompanySection({super.key});
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController logoUrlController = TextEditingController();
  final CompanyController companyController = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      width: 40.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Company",
            style: AppTextStyle.head_4,
          ),
          SizedBox(
            height: 5.h,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: companyNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Company Name can\'t be empty';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.building_2_fill),
                        hintText: 'Google',
                        labelText: 'Company Name *'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    controller: logoUrlController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'LogoURL can\'t be empty';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.link),
                        hintText: 'https://logo.com',
                        labelText: 'Logo URL *'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Obx(() {
                    return AppButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            companyController.addCompany({
                              "CompanyName": companyNameController.text.trim(),
                              "CompanyLogoURL": logoUrlController.text.trim()
                            });
                          }
                        },
                        buttonState: companyController.isAddCompanyLoading.value
                            ? ButtonState.loading
                            : ButtonState.active,
                        child: Text(
                          "Continue",
                          style:
                              AppTextStyle.CTA.copyWith(color: AppColors.white),
                        ));
                  })
                ],
              ))
        ],
      ),
    );
  }
}

class AvaildableCompaniesScection extends StatefulWidget {
  const AvaildableCompaniesScection({super.key});

  @override
  State<AvaildableCompaniesScection> createState() =>
      _AvaildableCompaniesScectionState();
}

class _AvaildableCompaniesScectionState
    extends State<AvaildableCompaniesScection> {
  final CompanyController companyController = Get.find();

  @override
  void initState() {
    // TODO: implement initState

    if (companyController.companyModel.value.compaines == null) {
      companyController.getCompanies();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Available Companies",
              style: AppTextStyle.head_4,
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(() {
              return companyController.isCompaniesLoading.value
                  ? const CircularProgressIndicator()
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.start,
                      spacing: 1.w,
                      runSpacing: 1.w,
                      children: companyController.companyModel.value.compaines!
                          .map((e) => FilterChip(
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(e.company ?? ""),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(e.companyLogo ?? ""),
                                    )
                                  ],
                                ),
                                onSelected: (bool value) {
                                  showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return _updateDeleteDialog(
                                          companyName: e.company!,
                                          companyLogoURL: e.companyLogo!,
                                          companyId: e.id!,
                                          companyController: companyController,
                                          buildContext: context);
                                    },
                                  );
                                },
                              ))
                          .toList(),
                    );
            })
          ],
        ),
      ),
    );
  }
}

Widget _updateDeleteDialog(
    {required String companyName,
    required String companyLogoURL,
    required int companyId,
    required CompanyController companyController,
    required BuildContext buildContext}) {
  TextEditingController companyTextEditingController = TextEditingController();
  TextEditingController logoTextEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
                  onTap: () => Navigator.of(buildContext).pop(),
                  child: Icon(CupertinoIcons.pencil_slash)),
              InkWell(
                onTap: () {
                  companyController.deleteCompany({
                    "CompanyId": companyId,
                  });
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: companyTextEditingController
                      ..text = companyName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Company Name can\'t be empty';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.building_2_fill),
                        hintText: 'Google',
                        labelText: 'Company Name *'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    controller: logoTextEditingController
                      ..text = companyLogoURL,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'LogoURL can\'t be empty';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.link),
                        hintText: 'https://logo.com',
                        labelText: 'Logo URL *'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Obx(() {
                    return AppButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            companyController.addCompany({
                              "companyId": companyId,
                              "companyName":
                                  companyTextEditingController.text.trim(),
                              "companyLogoURL":
                                  logoTextEditingController.text.trim()
                            });
                          }
                        },
                        buttonState: companyController.isAddCompanyLoading.value
                            ? ButtonState.loading
                            : ButtonState.active,
                        child: Text(
                          "Update",
                          style:
                              AppTextStyle.CTA.copyWith(color: AppColors.white),
                        ));
                  })
                ],
              ))
        ],
      ),
    ),
  );
}
