import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/controllers/detail_menu_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailMenuScreen extends StatelessWidget {
  const DetailMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailMenuController controller = Get.put(DetailMenuController());
    final int menuId = Get.arguments as int;

    // Fetch menu detail when screen is loaded
    controller.fetchMenuDetail(menuId);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(68.h),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 68.h,
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(111, 24, 24, 24),
                  blurRadius: 15,
                  spreadRadius: -1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'Detail Menu',
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.menuDetail.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final menu = controller.menuDetail;

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: menu['foto'] ??
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                  height: 200.h,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                menu['nama'] ?? 'Nama Tidak Tersedia',
                style: Get.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                menu['deskripsi'] ?? 'Deskripsi Tidak Tersedia',
                style: Get.textTheme.bodyMedium,
              ),
              SizedBox(height: 16.h),
              const Divider(),
              _buildDetailRow(
                  'Harga', Text(menu['harga']?.toString() ?? 'Tidak Tersedia')),
              const Divider(),
              _buildDetailRow('Level', _buildLevels(controller.levels)),
              const Divider(),
              _buildDetailRow('Topping', _buildToppings(controller.toppings)),
              const Divider(),
              _buildDetailRow('Catatan',
                  Text(menu['catatan']?.toString() ?? 'Tidak Tersedia')),
              const Divider(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailRow(String title, Widget value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Get.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          value,
        ],
      ),
    );
  }

  Widget _buildLevels(List<dynamic> levels) {
    if (levels.isEmpty) {
      return Text('Tidak Tersedia', style: Get.textTheme.bodyMedium);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: levels.map((level) {
        return Text(
          '${level['keterangan']} - ${level['harga']}',
          style: Get.textTheme.bodyMedium,
        );
      }).toList(),
    );
  }

  Widget _buildToppings(List<dynamic> toppings) {
    if (toppings.isEmpty) {
      return Text('Tidak Tersedia', style: Get.textTheme.bodyMedium);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: toppings.map((topping) {
        return Text(
          '${topping['keterangan']} - ${topping['harga']}',
          style: Get.textTheme.bodyMedium,
        );
      }).toList(),
    );
  }
}
