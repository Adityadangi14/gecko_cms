import 'package:flutter/material.dart';
import 'package:gecko_cms/core/colors/app_colors.dart';
import 'package:gecko_cms/widget-constants/button/button_loading_animation.dart';

import 'package:sizer/sizer.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.child,
    this.onPressed,
    this.height,
    this.width,
    this.backgroundColor,
    this.padding,
    this.border,
    this.borderRadius,
    this.alignment,
    this.buttonState = ButtonState.active,
    this.margin,
  });

  final double? height;
  final double? width;
  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final Border? border;
  final BorderRadius? borderRadius;
  final Alignment? alignment;
  final EdgeInsets? margin;
  final ButtonState buttonState;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            buttonState == ButtonState.disable
                ? AppColors.grey2
                : (backgroundColor ?? AppColors.primaryBlack)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        )),
      ),
      onPressed: buttonState == ButtonState.active ? onPressed : null,
      child: Container(
        height: height ?? 7.h,
        // width: width ?? 180,
        padding: const EdgeInsets.all(5),
        child: Center(child: getButtonChild(child, buttonState)),
      ),
    );
  }
}

Widget getButtonChild(Widget child, ButtonState buttonState) {
  if (buttonState == ButtonState.loading) {
    return const ButtonLoadingAnimation();
  }

  return child;
}

enum ButtonState {
  loading,
  active,
  disable,
}
