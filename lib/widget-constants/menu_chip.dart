import 'package:flutter/material.dart';
import 'package:gecko_cms/core/text-style/app_textstyle.dart';

class MenuChip extends StatelessWidget {
  const MenuChip(
      {super.key,
      required this.icon,
      required this.title,
      required this.selected});

  final Widget icon;

  final String title;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          color: selected ? Colors.lightGreen[300] : Colors.grey[200],
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: AppTextStyle.CTA,
          )
        ],
      ),
    );
  }
}
