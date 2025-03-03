import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/controllers/edit_menu_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

void showEditCatatanBottomSheet(BuildContext context,
    EditMenuController controller, TextEditingController catatanController) {
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
          initialChildSize: 0.3,
          minChildSize: 0.2,
          maxChildSize: 0.4,
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
                      'Buat Catatan'.tr,
                      style: Get.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: catatanController,
                            decoration: InputDecoration(
                              hintText: 'Masukkan catatan'.tr,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorStyle.primary,
                                ),
                              ),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorStyle.primary,
                                ),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorStyle.primary,
                                ),
                              ),
                            ),
                            maxLines: null,
                            maxLength: 100,
                          ),
                        ),
                        IconButton(
                          icon: const CircleAvatar(
                            backgroundColor: ColorStyle.primary,
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                          onPressed: () {
                            controller.catatan.value = catatanController.text;
                            Get.back();
                          },
                        ),
                      ],
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