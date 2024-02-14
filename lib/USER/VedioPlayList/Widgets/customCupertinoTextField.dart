import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCupertinoTextField extends StatelessWidget {
  final TextEditingController? searchController;
  final Widget? preffix;
  final void Function(String)? onChanged;
  final String? placeholder;

  const CustomCupertinoTextField(
      {super.key,
      this.searchController,
      this.onChanged,
      this.preffix,
      this.placeholder});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: searchController,
      prefix: preffix,
      onChanged: onChanged,
      // onTap: ,
      placeholder: placeholder,
      // padding: EdgeInsets.symmetric(horizontal: 5.w),
    );
  }
}
