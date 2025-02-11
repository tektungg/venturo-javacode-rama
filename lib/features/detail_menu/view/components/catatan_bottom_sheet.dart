import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

void showCatatanBottomSheet(BuildContext context,
    DetailMenuController controller, TextEditingController catatanController) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.1,
        maxChildSize: 0.2,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.r,
                right: 16.r,
                top: 16.r,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16.r,
              ),
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
                    'Buat Catatan',
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
                          decoration: const InputDecoration(
                            hintText: 'Masukkan catatan',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorStyle.primary,
                              ),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorStyle.primary,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
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
      );
    },
  );
}
