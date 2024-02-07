import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget value;
  final IconData? icon;
  final Color? iconBackgroundColor;
  final Color? color;
  final String? topTitle;
  final TextStyle? topTitleStyle;
  final void Function()? onTap;
  final String? title;
  final TextStyle? titleStyle;
  final Color? iconColor;
  const CustomCard({
    required this.value,
    super.key,
    this.icon,
    this.color = Colors.white,
    this.topTitle,
    this.topTitleStyle,
    this.iconBackgroundColor,
    this.iconColor,
    this.title,
    this.titleStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 2),
              color: Color.fromARGB(255, 206, 206, 206),
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  topTitle ?? "",
                  style: topTitleStyle,
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title ?? "",
              style: titleStyle,
            ),
            const SizedBox(height: 16),
            value,
          ],
        ),
      ),
    );
  }
}
