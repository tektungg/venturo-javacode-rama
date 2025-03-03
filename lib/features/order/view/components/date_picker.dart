import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTimeRange) onChanged;
  final DateTimeRange? selectDate;
  const DatePicker({super.key, required this.onChanged, this.selectDate});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late Rx<DateTime?> startDate;
  late Rx<DateTime?> endDate;

  @override
  void initState() {
    startDate = Rx<DateTime?>(widget.selectDate?.start);
    endDate = Rx<DateTime?>(widget.selectDate?.end);
    super.initState();
  }

  Future<void> _openDateRangePicker() async {
    final dateTimeRange = await showDateRangePicker(
      context: context,
      initialDateRange: widget.selectDate ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 30)),
            end: DateTime.now(),
          ),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      locale: Get.locale,
    );

    if (dateTimeRange != null) {
      startDate.value = dateTimeRange.start;
      endDate.value = dateTimeRange.end;
      widget.onChanged(dateTimeRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openDateRangePicker,
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 9.h,
        ),
        decoration: ShapeDecoration(
          color: ColorStyle.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: BorderSide(color: Theme.of(context).primaryColor, width: 1.w),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Obx(() {
                if (startDate.value == null || endDate.value == null) {
                  return Text(
                    'Pilih tanggal'.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.titleSmall?.copyWith(),
                  );
                } else {
                  return Text(
                    '${DateFormat('dd/MM/yy').format(startDate.value!)} - ${DateFormat('dd/MM/yy').format(endDate.value!)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.labelLarge?.copyWith(
                      fontSize: 12.sp,
                    ),
                  );
                }
              }),
            ),
            5.horizontalSpace,
            Icon(
              Icons.date_range,
              size: 24.r,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
