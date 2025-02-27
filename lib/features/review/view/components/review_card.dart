import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/utils/functions/string_utils.dart' as string_utils;

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewCard({required this.review, super.key});

  @override
  Widget build(BuildContext context) {
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
            spreadRadius: 5,
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
                style: Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.primary,
                ),
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    Icons.star,
                    color: i < review['rating'] ? Colors.amber : Colors.grey,
                    size: 20.r,
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            string_utils.truncateWithEllipsis(review['review'], 50),
            style: Get.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
