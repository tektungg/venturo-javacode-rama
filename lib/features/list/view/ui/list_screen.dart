import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:venturo_core/constants/core/assets/image_constant.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/features/list/view/components/menu_card.dart';
import 'package:venturo_core/features/list/view/components/menu_chip.dart';
import 'package:venturo_core/features/list/view/components/promo_card.dart';
import 'package:venturo_core/features/list/view/components/search_app_bar.dart';
import 'package:venturo_core/features/list/view/components/section_header.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Get.put(ListController());
    return SafeArea(
      child: Scaffold(
        appBar: SearchAppBar(
          searchController: TextEditingController(),
          onChange: (value) {
            ListController.to.keyword(value);
          },
        ),
        body: Column(
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
                          ListController.to.selectedCategory.value == category;
                      IconData icon;
                      switch (category) {
                        case 'Makanan':
                          icon = Icons.local_dining;
                          break;
                        case 'Minuman':
                          icon = Icons.local_drink;
                          break;
                        case 'Snack':
                          icon = Icons.kebab_dining;
                          break;
                        default:
                          icon = Icons.list_alt;
                      }
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: MenuChip(
                          text: category,
                          icon: icon,
                          isSelected: isSelected,
                          onTap: () {
                            ListController.to.selectedCategory(category);
                            ListController.to.getListOfData();
                            _scrollController.jumpTo(0);
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
              child: Obx(
                () => SmartRefresher(
                  controller: ListController.to.refreshController,
                  enablePullDown: true,
                  onRefresh: ListController.to.onRefresh,
                  enablePullUp: false,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    itemBuilder: (context, index) {
                      final item = ListController.to.filteredList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.5.h),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  ListController.to.deleteItem(item);
                                },
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(10.r),
                                ),
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.r),
                            elevation: 2,
                            child: MenuCard(
                              key: ValueKey(item['id_menu']),
                              menu: item,
                              isSelected: ListController.to.selectedItems
                                  .contains(item),
                              onTap: () {
                                setState(() {
                                  if (ListController.to.selectedItems
                                      .contains(item)) {
                                    ListController.to.selectedItems
                                        .remove(item);
                                  } else {
                                    ListController.to.selectedItems.add(item);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: ListController.to.filteredList.length,
                    itemExtent: 112.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
