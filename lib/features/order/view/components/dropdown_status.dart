import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownStatus extends StatelessWidget {
  final Map<String, String> items;
  final String selectedItem;
  final void Function(String?)? onChanged;
  const DropdownStatus(
      {super.key,
      required this.items,
      required this.selectedItem,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30.r),
      child: DropdownButtonFormField2(
        isDense: true,
        isExpanded: true,
        value: selectedItem,
        style: Get.textTheme.titleSmall,
        alignment: Alignment.bottomCenter,
        onChanged: onChanged,
        iconStyleData: const IconStyleData(
          iconEnabledColor: Colors.black87,
        ),
        buttonStyleData: ButtonStyleData(
          height: 37.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
        ),
        dropdownStyleData: DropdownStyleData(
          offset: Offset(0.h, -8.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.only(left: 15.w),
        ),
        selectedItemBuilder: (context) => items.entries
            .map(
              (entry) => Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  entry.value,
                  style: Get.textTheme.titleSmall,
                ),
              ),
            )
            .toList(),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 4.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1.w),
          ),
        ),
        items: items.entries.map((entry) {
          return DropdownMenuItem(
            value: entry.key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  entry.value,
                  style: Get.textTheme.titleSmall?.copyWith(
                      color: selectedItem == entry.key
                          ? Theme.of(context).primaryColor
                          : Colors.black87),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
