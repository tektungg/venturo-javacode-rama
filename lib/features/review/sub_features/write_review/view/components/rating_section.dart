import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class RatingSection extends StatelessWidget {
  final int selectedRating;
  final Function(int) onRatingSelected;
  final List<String> _ratingDescriptions = [
    'Buruk'.tr,
    'Kurang'.tr,
    'Cukup'.tr,
    'Baik'.tr,
    'Sempurna'.tr,
  ];

  RatingSection({
    super.key,
    required this.selectedRating,
    required this.onRatingSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorStyle.tertiary,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berikan Penilaianmu!'.tr,
            style: Get.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              for (int i = 1; i <= 5; i++)
                GestureDetector(
                  onTap: () => onRatingSelected(i),
                  child: Icon(
                    Icons.star,
                    color: i <= selectedRating ? Colors.amber : Colors.grey,
                    size: 38.r,
                  ),
                ),
              SizedBox(width: 10.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    selectedRating > 0
                        ? _ratingDescriptions[selectedRating - 1]
                        : '',
                    style: Get.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
