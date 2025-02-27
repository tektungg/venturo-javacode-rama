import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/review/controllers/review_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class ReviewInputImprovementSection extends StatelessWidget {
  final List<String> selectedImprovements;
  final Function(String) onImprovementSelected;
  final TextEditingController reviewController;
  final int selectedRating;
  final List<String> _improvementOptions = [
    'Harga',
    'Rasa',
    'Penyajian Makanan',
    'Pelayanan',
    'Fasilitas'
  ];

  ReviewInputImprovementSection({
    super.key,
    required this.selectedImprovements,
    required this.onImprovementSelected,
    required this.reviewController,
    required this.selectedRating,
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
            'Apa yang bisa ditingkatkan?',
            style: Get.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _improvementOptions.map((option) {
              final isSelected = selectedImprovements.contains(option);
              return ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(option),
                    if (isSelected)
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.r,
                        ),
                      ),
                  ],
                ),
                showCheckmark: false,
                selected: isSelected,
                onSelected: (selected) => onImprovementSelected(option),
                selectedColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.transparent
                        : Theme.of(context).primaryColor,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 10.h),
          Text(
            'Tulis Review',
            style: Get.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: reviewController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Ketik review Anda di sini...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (reviewController.text.isNotEmpty) {
                      ReviewController.to.addReview({
                        'improvements': selectedImprovements,
                        'rating': selectedRating,
                        'review': reviewController.text,
                      });
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorStyle.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: const Text(
                    'Kirim Penilaian',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () {
                  // Handle add photo
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
