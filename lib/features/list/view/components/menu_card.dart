import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/utils/services/network_service.dart';

class MenuCard extends StatefulWidget {
  final Map<String, dynamic> menu;
  final bool isSelected;
  final void Function()? onTap;

  const MenuCard({
    super.key,
    required this.menu,
    this.onTap,
    this.isSelected = false,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  late Future<bool> imageExists;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = _validateImageUrl(widget.menu['foto']);
    imageExists = NetworkService.checkImageUrl(
        imageUrl); // Verifikasi jika URL adalah gambar yang valid
  }

  /// 🔹 Fungsi untuk memvalidasi URL sebelum digunakan
  String _validateImageUrl(dynamic url) {
    if (url == null || url.toString().isEmpty) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';
    }
    return url.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: widget.isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
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
              child: FutureBuilder<bool>(
                future: imageExists,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || snapshot.data == false) {
                    // Jika gambar tidak valid atau terjadi error, tampilkan fallback image
                    return Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                      fit: BoxFit.contain,
                    );
                  }

                  // Gunakan CachedNetworkImage jika gambar valid
                  return CachedNetworkImage(
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
                    widget.menu['name'] ?? 'Menu Tanpa Nama',
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    widget.menu['harga']?.toString() ?? 'Harga Tidak Tersedia',
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
    );
  }
}
