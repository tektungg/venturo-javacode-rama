import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/shared/styles/color_style.dart';

class BottomNavbar extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;

  BottomNavbar({super.key}) {
    // Update selectedIndex based on the current route
    switch (Get.currentRoute) {
      case Routes.listRoute:
        selectedIndex.value = 0;
        break;
      case Routes.orderRoute:
        selectedIndex.value = 1;
        break;
      case Routes.orderDetailRoute:
        selectedIndex.value = 1;
        break;
      case Routes.profileRoute:
        selectedIndex.value = 2;
        break;
      default:
        selectedIndex.value = 0;
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed(Routes.listRoute);
        break;
      case 1:
        Get.toNamed(Routes.orderRoute);
        break;
      case 2:
        Get.toNamed(Routes.profileRoute);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          child: BottomNavigationBar(
            backgroundColor: ColorStyle.dark,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: selectedIndex.value,
            onTap: onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Beranda'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.room_service),
                label: 'Pesanan'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle_outlined),
                label: 'Profil'.tr,
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontSize: 12.sp),
            unselectedLabelStyle: TextStyle(fontSize: 12.sp),
          ),
        ));
  }
}