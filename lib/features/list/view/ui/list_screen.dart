import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/features/list/view/components/menu_card.dart';
import 'package:venturo_core/features/list/view/components/menu_chip.dart';
import 'package:venturo_core/features/list/view/components/promo_card.dart';
import 'package:venturo_core/features/list/view/components/search_app_bar.dart';
import 'package:venturo_core/features/list/view/components/section_header.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        searchController: TextEditingController(),
        onChange: (value) {
          ListController.to.keyword(value);
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            const Padding(
              padding: EdgeInsets.symmetric(),
              child: SectionHeader(
                title: 'Available Promos',
                icon: Icons.local_offer,
              ),
            ),
            SizedBox(height: 10.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                children: [
                  const PromoCard(
                    promoName: 'Promo 1',
                    discountNominal: '20',
                    thumbnailUrl: ImageConstant.promo1,
                    enableShadow: true,
                  ),
                  SizedBox(width: 10.w),
                  const PromoCard(
                    promoName: 'Promo 2',
                    discountNominal: '30',
                    thumbnailUrl: ImageConstant.promo2,
                    enableShadow: true,
                  ),
                  SizedBox(width: 10.w),
                  const PromoCard(
                    promoName: 'Promo 3',
                    discountNominal: '50',
                    thumbnailUrl: ImageConstant.promo3,
                    enableShadow: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ListController.to.categories.map((category) {
                      final isSelected =
                          ListController.to.selectedCategory.value ==
                              category.toLowerCase();
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: MenuChip(
                          text: category,
                          isSelected: isSelected,
                          onTap: () {
                            ListController.to
                                .selectedCategory(category.toLowerCase());
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
            SizedBox(height: 20.h),
            const Padding(
              padding: EdgeInsets.symmetric(),
              child: SectionHeader(
                title: 'Menu',
                icon: Icons.menu_book,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  itemBuilder: (context, index) {
                    final item = ListController.to.filteredList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.5.h),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.r),
                        elevation: 2,
                        child: MenuCard(
                          menu: item,
                          isSelected:
                              ListController.to.selectedItems.contains(item),
                          onTap: () {
                            if (ListController.to.selectedItems
                                .contains(item)) {
                              ListController.to.selectedItems.remove(item);
                            } else {
                              ListController.to.selectedItems.add(item);
                            }
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: ListController.to.filteredList.length,
                  itemExtent: 112.h,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
