import 'package:flutter/material.dart';
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
