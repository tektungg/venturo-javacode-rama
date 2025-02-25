import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

Widget buildSectionTitle(String title) {
  return Text(
    title.tr,
    style: Get.textTheme.titleLarge!
        .copyWith(color: ColorStyle.primary, fontWeight: FontWeight.bold),
  );
}