import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/review/sub_features/write_review/view/components/app_bar.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';
import 'package:venturo_core/utils/functions/string_utils.dart' as string_utils;

class ReviewScreen extends StatelessWidget {
  ReviewScreen({super.key});

  final List<Map<String, dynamic>> reviews = [
    {
      'improvements': ['Harga', 'Rasa'],
      'rating': 4,
      'review': 'Makanan enak, harga terjangkau, pelayanan cepat.',
    },
    {
      'improvements': ['Pelayanan'],
      'rating': 5,
      'review': 'Pelayanan sangat memuaskan, ramah dan cepat.',
    },
  ];

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
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: ColorStyle.tertiary,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['improvements'].join(', '),
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorStyle.primary,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (i) {
                          return Icon(
                            Icons.star,
                            color: i < review['rating']
                                ? Colors.amber
                                : Colors.grey,
                            size: 20.r,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    string_utils.truncateWithEllipsis(review['review'], 100),
                    style: Get.textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.writeReviewRoute);
        },
        backgroundColor: ColorStyle.primary,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
