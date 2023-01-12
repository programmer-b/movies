import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class KFMovieDetailActionButtonBuilder extends StatelessWidget {
  const KFMovieDetailActionButtonBuilder(
      {Key? key, required this.onTap, required this.icon, required this.text})
      : super(key: key);
  final Function()? onTap;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: width * 0.20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
            ),
            8.height,
            Text(
              text,
              style: secondaryTextStyle(color: Colors.white, size: 12),
            )
          ],
        ),
      ),
    );
  }
}