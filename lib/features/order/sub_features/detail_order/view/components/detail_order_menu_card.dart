import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class DetailOrderMenuCard extends StatelessWidget {
  final Map<String, dynamic> menu;
  final int jumlah;

  const DetailOrderMenuCard({
    super.key,
    required this.menu,
    required this.jumlah,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl = menu['foto'] ??
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';

    // Convert harga to int
    final int harga = int.tryParse(menu['harga'].toString()) ?? 0;

    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: ColorStyle.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: -1,
            ),
          ],
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
                    menu['nama'] ?? 'Menu Tanpa Nama'.tr,
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(harga)}',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.edit_note,
                        size: 16.r,
                        color: ColorStyle.primary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          'Catatan: %s'.trArgs([menu['catatan'] ?? 'Tidak ada catatan'.tr]),
                          style: Get.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 75.r,
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$jumlah',
                    style: Get.textTheme.titleMedium,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
