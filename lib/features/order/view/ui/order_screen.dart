import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/features/order/view/components/dropdown_status.dart';
import 'package:venturo_core/features/order/view/components/date_picker.dart';
import 'package:venturo_core/features/order/view/components/order_top_bar.dart';
import 'package:venturo_core/features/order/view/ui/ongoing_order_tab.dart';
import 'package:venturo_core/features/order/view/ui/order_history_tab.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: const OrderTopBar(),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return DropdownStatus(
                          items: OrderController.to.dateFilterStatus,
                          selectedItem:
                              OrderController.to.selectedCategory.value,
                          onChanged: (value) {
                            if (value != null) {
                              OrderController.to.setDateFilter(category: value);
                            }
                          },
                        );
                      }),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Obx(() {
                        return DatePicker(
                          selectDate:
                              OrderController.to.selectedDateRange.value,
                          onChanged: (dateRange) {
                            OrderController.to.setDateFilter(range: dateRange);
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    const TabBarView(
                      children: [
                        OnGoingOrderTabScreen(),
                        OrderHistoryTabScreen(),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: BottomNavbar(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
