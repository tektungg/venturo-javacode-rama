import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/list/sub_features/promo/repositories/promo_repository.dart';
import 'package:venturo_core/configs/routes/route.dart';

class PromoCard extends StatelessWidget {
  final String promoName;
  final String discountNominal;
  final String thumbnailUrl;
  final bool enableShadow;
  final double? width;
  final int promoId;

  const PromoCard({
    super.key,
    required this.promoName,
    required this.discountNominal,
    required this.thumbnailUrl,
    this.enableShadow = false,
    this.width,
    required this.promoId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          final promoDetail = await PromoRepository().getPromoDetail(promoId);
          Get.toNamed(Routes.promoRoute, arguments: promoDetail);
        } catch (e) {
          Get.snackbar('Error', 'Failed to load promo detail');
        }
      },
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        width: width ?? 282.w,
        height: 188.h,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
            image: NetworkImage(thumbnailUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor.withAlpha(150),
              BlendMode.srcATop,
            ),
          ),
          boxShadow: [
            if (enableShadow == true)
              const BoxShadow(
                color: Color.fromARGB(115, 71, 70, 70),
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                softWrap: true,
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'Diskon',
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: ' $discountNominal %',
                      style: Get.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                promoName,
                textAlign: TextAlign.center,
                style: Get.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}