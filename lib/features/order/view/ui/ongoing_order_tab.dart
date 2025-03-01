import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/order/controllers/order_controller.dart';
import 'package:venturo_core/features/order/view/components/order_item_card.dart';

class OnGoingOrderTabScreen extends StatelessWidget {
  const OnGoingOrderTabScreen({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Ongoing Order Screen',
      screenClassOverride: 'Trainee',
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstant.bgPattern2),
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(80, 255, 255, 255),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: () async => OrderController.to.getOngoingOrders(),
            child: Obx(
              () => ConditionalSwitch.single(
                context: context,
                valueBuilder: (context) =>
                    OrderController.to.onGoingOrderState.value,
                caseBuilders: {
                  'loading': (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  'empty': (context) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.orderEmpty,
                              width: 200.w,
                              height: 200.h,
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: const Text(
                                'Sudah pesan?\n Lacak pesananmu di sini',
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                  'error': (context) => const Center(
                        child: Text('Failed to load ongoing orders'),
                      ),
                  'success': (context) => ListView.separated(
                        padding: EdgeInsets.all(25.r),
                        itemBuilder: (context, index) => OrderItemCard(
                          order: OrderController.to.onGoingOrders[index],
                          onTap: () {
                            Get.toNamed(
                              '${Routes.orderRoute}/${OrderController.to.onGoingOrders[index]['id_order']}',
                            );
                          },
                          showButtons: false,
                        ),
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemCount: OrderController.to.onGoingOrders.length,
                      ),
                },
                fallbackBuilder: (context) => const Center(
                  child: Text('Unknown state'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
