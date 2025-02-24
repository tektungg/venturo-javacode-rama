import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/features/list/view/components/category_section.dart';
import 'package:venturo_core/features/list/view/components/menu_chip.dart';
import 'package:venturo_core/features/list/view/components/menu_item.dart';
import 'package:venturo_core/features/list/view/components/promo_card.dart';
import 'package:venturo_core/features/list/view/components/search_app_bar.dart';
import 'package:venturo_core/features/list/view/components/section_header.dart';
import 'package:venturo_core/shared/widgets/checkout_fab.dart';
import 'package:venturo_core/shared/widgets/bottom_navbar.dart';
import 'package:venturo_core/features/list/sub_features/promo/controllers/list_promo_controller.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  final ScrollController _scrollController = ScrollController();
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    Get.put(ListPromoController()); // Initialize ListPromoController
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ListController());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SearchAppBar(
          searchController: TextEditingController(),
          onChange: (value) {
            ListController.to.keyword(value);
          },
        ),
        body: Stack(
          children: [
            Column(
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
                Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      children: ListPromoController.to.promos.map((promo) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: PromoCard(
                            promoName: promo['nama'] ?? 'Promo Tanpa Nama',
                            discountNominal: promo['diskon']?.toString() ?? '0',
                            thumbnailUrl: promo['foto'] ??
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                            enableShadow: true,
                            promoId: promo['id_promo'],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
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
                                  category;
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
                SizedBox(height: 10.h),
                Expanded(
                  child: Obx(
                    () => SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      onRefresh: ListController.to.onRefresh,
                      enablePullUp: false,
                      child: ListView(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        children: [
                          if (ListController.to.selectedCategory.value ==
                              'Semua') ...[
                            buildCategorySection(
                              'Makanan',
                              ListController.to.filteredList
                                  .where((item) =>
                                      item['kategori']
                                          .toString()
                                          .toLowerCase() ==
                                      'makanan')
                                  .toList(),
                              Icons.local_dining,
                            ),
                            buildCategorySection(
                              'Minuman',
                              ListController.to.filteredList
                                  .where((item) =>
                                      item['kategori']
                                          .toString()
                                          .toLowerCase() ==
                                      'minuman')
                                  .toList(),
                              Icons.local_drink,
                            ),
                            buildCategorySection(
                              'Snack',
                              ListController.to.filteredList
                                  .where((item) =>
                                      item['kategori']
                                          .toString()
                                          .toLowerCase() ==
                                      'snack')
                                  .toList(),
                              Icons.kebab_dining,
                            ),
                          ] else ...[
                            for (var item in ListController.to.filteredList)
                              buildMenuItem(item),
                          ],
                          SizedBox(height: 80.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavbar(),
            ),
          ],
        ),
        floatingActionButton: const CheckoutFAB(),
      ),
    );
  }
}
