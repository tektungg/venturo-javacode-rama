import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 2.r,
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.1,
          maxChildSize: 0.2,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 155.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Ganti Bahasa'.tr,
                      style: Get.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: ['Indonesia', 'English'].map((language) {
                        final isSelected = Get.locale?.languageCode ==
                            (language == 'Indonesia' ? 'id' : 'en');
                        final flagImage = language == 'Indonesia'
                            ? ImageConstant.flagIndonesia
                            : ImageConstant.flagEnglish;
                        return ChoiceChip(
                          showCheckmark: false,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                flagImage,
                                width: 78.w,
                                height: 78.h,
                              ),
                              SizedBox(width: 8.w),
                              Text(language),
                              if (isSelected)
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 24.r,
                                  ),
                                ),
                            ],
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              Get.updateLocale(Locale(
                                  language == 'Indonesia' ? 'id' : 'en'));
                              Logger().i('Language changed to $language');
                            }
                          },
                          selectedColor: Theme.of(context).primaryColor,
                          backgroundColor: Colors.grey[200],
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
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
