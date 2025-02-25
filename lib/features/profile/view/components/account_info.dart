import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/profile/controllers/profile_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/features/profile/view/components/info_row.dart';

Widget buildAccountInfo() {
  return Container(
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: ColorStyle.white,
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Obx(() {
      final profile = ProfileController.to.userProfile;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoRow('Nama', profile['nama'] ?? 'N/A', 'nama'),
          const Divider(),
          buildInfoRow('Tanggal Lahir', profile['tgl_lahir'] ?? 'N/A', 'tgl_lahir'),
          const Divider(),
          buildInfoRow('No. Telepon', profile['telepon'] ?? 'N/A', 'telepon'),
          const Divider(),
          buildInfoRow('Email', profile['email'] ?? 'N/A', 'email'),
          const Divider(),
          buildInfoRow('PIN', profile['pin'] ?? 'N/A', 'pin'),
          const Divider(),
          buildInfoRow('Ganti Bahasa', 'Pilih Bahasa'),
        ],
      );
    }),
  );
}