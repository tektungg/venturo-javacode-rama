import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';

void showCatatanBottomSheet(BuildContext context,
    DetailMenuController controller, TextEditingController catatanController) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.1,
        maxChildSize: 0.5,
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
                    style: Get.textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: catatanController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan catatan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      controller.catatan.value = catatanController.text;
                      Get.back();
                    },
                    child: Text('Simpan'),
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
