import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/review/repositories/review_repository.dart';
import 'package:venturo_core/features/review/sub_features/write_review/view/components/app_bar.dart';
import 'package:venturo_core/features/review/view/components/review_card.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle('Daftar Penilaian'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.bgPattern2),
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
              Color.fromARGB(80, 255, 255, 255),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 25.r),
          itemCount: ReviewRepository.reviews.length,
          itemBuilder: (context, index) {
            final review = ReviewRepository.reviews[index];
            return ReviewCard(review: review);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.writeReviewRoute);
        },
        backgroundColor: ColorStyle.primary,
        child: const Icon(
          Icons.add,
          color: ColorStyle.white,
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}