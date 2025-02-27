import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RatingSection extends StatelessWidget {
  final int selectedRating;
  final Function(int) onRatingSelected;
  final List<String> _ratingDescriptions = [
    'Buruk',
    'Kurang',
    'Cukup',
    'Baik',
    'Sempurna'
  ];

  RatingSection({super.key, 
    required this.selectedRating,
    required this.onRatingSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Text(
            'Berikan Penilaianmu!',
            style: Get.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              for (int i = 1; i <= 5; i++)
                IconButton(
                  icon: Icon(
                    Icons.star,
                    color: i <= selectedRating ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () => onRatingSelected(i),
                ),
              SizedBox(width: 10.w),
              Text(
                selectedRating > 0 ? _ratingDescriptions[selectedRating - 1] : '',
                style: Get.textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}