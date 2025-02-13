import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoImage extends StatelessWidget {
  final String imageUrl;

  const PromoImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) {
              // Jika error, tampilkan gambar fallback
              return Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}