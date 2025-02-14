import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/controllers/voucher_controller.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/repositories/voucher_repository.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/components/voucher_app_bar.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/components/voucher_item.dart';
import 'package:venturo_core/features/checkout/sub_features/voucher/view/components/voucher_bottom_bar.dart';

class VoucherScreen extends StatelessWidget {
  VoucherScreen({super.key});

  final VoucherController controller = Get.put(VoucherController());
  final VoucherRepository repository = VoucherRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildVoucherAppBar(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: repository.fetchVouchers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No vouchers available'));
          } else {
            final vouchers = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.r),
                    itemCount: vouchers.length,
                    itemBuilder: (context, index) {
                      final voucher = vouchers[index];
                      return VoucherItem(voucher: voucher);
                    },
                  ),
                ),
                buildVoucherBottomBar(controller),
              ],
            );
          }
        },
      ),
    );
  }
}