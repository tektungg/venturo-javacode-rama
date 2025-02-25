import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/profile/view/components/app_bar.dart';
import 'package:venturo_core/features/profile/view/components/profile_icon.dart';
import 'package:venturo_core/features/profile/view/components/section_title.dart';
import 'package:venturo_core/features/profile/view/components/account_info.dart';
import 'package:venturo_core/features/profile/view/components/rating_section.dart';
import 'package:venturo_core/features/profile/view/components/other_info.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgPattern2),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
          children: [
            buildProfileIcon(context),
            SizedBox(height: 20.h),
            buildSectionTitle('Info Akun'),
            SizedBox(height: 10.h),
            buildAccountInfo(),
            SizedBox(height: 10.h),
            buildRatingSection(),
            SizedBox(height: 20.h),
            buildSectionTitle('Info Lainnya'),
            SizedBox(height: 10.h),
            buildOtherInfo(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}