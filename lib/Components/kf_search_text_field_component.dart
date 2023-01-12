import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class KFsearchTextFieldComponent extends StatelessWidget {
  const KFsearchTextFieldComponent(
      {super.key, this.onSearch, this.onChanged, required this.controller});
  final Function()? onSearch;
  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white30,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.transparent,
            suffixIcon: IconButton(
              onPressed: onSearch,
              icon: const Icon(Icons.search, color: white),
            ),
            hintText: "Search for movies, tv shows, animation and more...",
            hintStyle: primaryTextStyle(color: white, size: 13),
          )),
    );
  }
}
