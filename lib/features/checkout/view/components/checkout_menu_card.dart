import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/shared/styles/color_style.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';

class CheckoutMenuCard extends StatelessWidget {
  final Map<String, dynamic> menu;
  final CheckoutController controller = Get.find();

  CheckoutMenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = menu['foto'] ??
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';

    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(Routes.editMenuRoute, arguments: menu);
          },
          borderRadius: BorderRadius.circular(10.r),
          child: Ink(
            padding: EdgeInsets.all(7.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Colors.transparent,
                width: 2.w,
              ),
            ),
            child: Row(
              children: [
                // menu image
                Container(
                  height: 90.h,
                  width: 90.w,
                  margin: EdgeInsets.only(right: 12.r),
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey[100],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) {
                      // Jika error, tampilkan gambar fallback
                      return Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                // menu info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu['nama'] ?? 'Menu Tanpa Nama',
                        style: Get.textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(menu['harga'] ?? 0)}',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10.w,
          top: 38.h,
          child: Row(
            children: [
              // Decrement Button
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorStyle.primary),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    if (menu['jumlah'] > 1) {
                      menu['jumlah']--;
                    } else {
                      controller.menuList.remove(menu);
                    }
                    controller.calculateTotal();
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: ColorStyle.primary,
                    size: 15,
                  ),
                ),
              ),
              // Quantity Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  '${menu['jumlah']}',
                  style: Get.textTheme.bodyLarge,
                ),
              ),
              // Increment Button
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: ColorStyle.primary,
                  border: Border.all(color: ColorStyle.primary),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    menu['jumlah']++;
                    controller.calculateTotal();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20.h,
          left: 111.w,
          child: Text(
            'Catatan: ${menu['catatan'] ?? 'Tidak ada catatan'}',
            style: Get.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}