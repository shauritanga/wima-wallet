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
        decoration: BoxDecoration(
          color: color,
          border: const Border(
              left: BorderSide(width: 5, color: Color(0xff102d61))),
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.5, 1),
              color: Color.fromARGB(255, 206, 206, 206),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 10,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  topTitle ?? "",
                  style: topTitleStyle,
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title ?? "",
              style: titleStyle,
            ),
            const SizedBox(height: 4),
            value,
          ],
        ),
      ),
    );
  }
}
