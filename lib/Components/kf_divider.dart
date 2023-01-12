import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class KFDivider extends StatelessWidget {
  const KFDivider({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      child: Stack(
        alignment: Alignment.center,
        children: [
          const Divider(
            color: Colors.grey,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            color: Colors.black,
            child: Text(
              text,
              style: boldTextStyle(size: 17, color: Colors.white60),
            ).fit(),
          )
        ],
      ),
    );
  }
}
