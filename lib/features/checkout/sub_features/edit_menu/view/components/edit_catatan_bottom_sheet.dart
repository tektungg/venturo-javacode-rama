import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/edit_menu/controllers/edit_menu_controller.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Catatan',
                      style: Get.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.h),
                    TextField(
                      controller: catatanController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Tambahkan catatan...',
                      ),
                      onChanged: (value) {
                        controller.catatan.value = value;
                      },
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        controller.catatan.value = catatanController.text;
                        Get.back();
                      },
                      child: const Text('Simpan'),
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