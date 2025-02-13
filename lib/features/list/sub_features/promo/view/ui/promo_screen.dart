import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/list/sub_features/promo/view/components/promo_app_bar.dart';
import 'package:venturo_core/features/list/sub_features/promo/view/components/promo_image.dart';
import 'package:venturo_core/features/list/sub_features/promo/view/components/promo_details.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> promo = Get.arguments as Map<String, dynamic>;
    final String imageUrl = promo['foto'] ??
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';

    return Scaffold(
      appBar: const PromoAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                PromoImage(imageUrl: imageUrl),
                SizedBox(height: 16.h),
                PromoDetails(promo: promo),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
