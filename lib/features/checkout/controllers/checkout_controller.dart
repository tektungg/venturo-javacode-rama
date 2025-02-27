import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/detail_menu/repositories/detail_menu_repository.dart';
import 'package:venturo_core/features/checkout/sub_features/discount/controllers/discount_controller.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();

  final RxList<Map<String, dynamic>> menuList = <Map<String, dynamic>>[].obs;
  final RxInt totalHarga = 0.obs;
  final RxInt totalPembayaran = 0.obs;
  final RxInt totalMenuDipesan = 0.obs;
  final RxInt totalVoucherNominal = 0.obs;
  final RxInt totalDiskonNominal = 0.obs;
  final Rx<Map<String, dynamic>?> selectedVoucher =
      Rx<Map<String, dynamic>?>(null);

  final DetailMenuRepository detailMenuRepository = DetailMenuRepository();
  final DiscountController discountController = Get.find();
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    // Fetch menu list and calculate total price
    try {
      logger.d('Initializing CheckoutController');
      loadOrdersFromHive();
      fetchMenuDetails();
    } catch (e) {
      logger.e('Error in CheckoutController onInit');
    }
  }

  void loadOrdersFromHive() {
    try {
      logger.d('Loading orders from Hive');
      var box = Hive.box('orders');
      final orders = box.values
          .cast<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      menuList.addAll(orders);
      calculateTotal();
      logger.d('Orders loaded from Hive: ${menuList.length}');
    } catch (e) {
      logger.e('Error in loadOrdersFromHive: $e');
    }
  }

  Future<void> clearOrders() async {
    try {
      logger.d('Clearing orders from Hive');
      var box = Hive.box('orders');
      await box.clear();
      menuList.clear();
      calculateTotal();
      logger.d('Orders cleared from Hive');
    } catch (e) {
      logger.e('Error in clearOrders: $e');
    }
  }

  void fetchMenuDetails() async {
    try {
      logger.d('Fetching menu details');
      for (var menu in menuList) {
        var menuDetail =
            await detailMenuRepository.fetchMenuDetail(menu['id_menu']);
        menu['foto'] = menuDetail['foto'];
      }
      menuList.refresh();
      logger.d('Menu details fetched successfully');
      calculateTotal();
    } catch (e) {
      logger.e('Error in fetchMenuDetails: $e');
    }
  }

  void calculateTotal() {
    try {
      logger.d('Calculating total');
      int total = 0;
      int totalItems = 0;
      for (var menu in menuList) {
        total += (menu['harga'] as int) * (menu['jumlah'] as int);
        totalItems += menu['jumlah'] as int;
      }
      totalHarga.value = total;
      calculateTotalDiscount();
      totalPembayaran.value =
          (total - totalVoucherNominal.value - totalDiskonNominal.value)
              .clamp(10000, total);
      totalMenuDipesan.value = totalItems;
      logger.d('Total calculated: $total, Total items: $totalItems');
    } catch (e) {
      logger.e('Error in calculateTotal: $e');
    }
  }

  void calculateTotalDiscount() {
    try {
      logger.d('Calculating total discount');
      int totalDiskon = 0;
      for (var discount in discountController.discounts) {
        totalDiskon += discount['diskon'] as int;
      }
      totalDiskonNominal.value = totalHarga.value * totalDiskon ~/ 100;
      logger.d('Total discount calculated: ${totalDiskonNominal.value}');
    } catch (e) {
      logger.e('Error in calculateTotalDiscount: $e');
    }
  }

  void applyVoucher(Map<String, dynamic>? voucher) {
    try {
      if (voucher == null || voucher.isEmpty) {
        logger.d('Removing voucher');
        selectedVoucher.value = null;
        totalVoucherNominal.value = 0;
        restoreDiscounts(); // Restore discounts when voucher is removed
      } else {
        logger.d('Applying voucher: ${voucher['nominal']}');
        selectedVoucher.value = voucher;
        totalVoucherNominal.value = voucher['nominal'] as int;
        removeDiscounts(); // Remove discounts when voucher is applied
      }
      calculateTotal();
    } catch (e) {
      logger.e('Error in applyVoucher: $e');
    }
  }

  void removeDiscounts() {
    try {
      logger.d('Removing discounts');
      discountController.discounts.clear();
      totalDiskonNominal.value = 0;
      calculateTotal();
    } catch (e) {
      logger.e('Error in removeDiscounts: $e');
    }
  }

  void restoreDiscounts() {
    try {
      logger.d('Restoring discounts');
      // Logic to restore discounts
      discountController
          .fetchDiscounts(); // Assuming fetchDiscounts() will restore the discounts
      calculateTotal(); // Recalculate total after restoring discounts
    } catch (e) {
      logger.e('Error in restoreDiscounts: $e');
    }
  }

  Map<String, List<Map<String, dynamic>>> get groupedMenuByCategory {
    try {
      logger.d('Grouping menu by category');
      Map<String, List<Map<String, dynamic>>> groupedMenu = {};
      for (var menu in menuList) {
        String category = menu['kategori'] ?? 'Lainnya';
        if (!groupedMenu.containsKey(category)) {
          groupedMenu[category] = [];
        }
        groupedMenu[category]!.add(menu);
      }
      return groupedMenu;
    } catch (e) {
      logger.e('Error in groupedMenuByCategory: $e');
      return {};
    }
  }

  void updateMenu(Map<String, dynamic> updatedMenu) {
    try {
      logger.d('Updating menu: ${updatedMenu['id_menu']}');
      int index = menuList
          .indexWhere((menu) => menu['id_menu'] == updatedMenu['id_menu']);
      if (index != -1) {
        menuList[index] = updatedMenu;
        var box = Hive.box('orders');
        box.putAt(index, updatedMenu);
        calculateTotal();
        logger.d('Menu updated: $updatedMenu');
      }
    } catch (e) {
      logger.e('Error in updateMenu: $e');
    }
  }

  void removeMenu(int menuId) {
    try {
      logger.d('Removing menu: $menuId');
      int index = menuList.indexWhere((menu) => menu['id_menu'] == menuId);
      if (index != -1) {
        menuList.removeAt(index);
        var box = Hive.box('orders');
        box.deleteAt(index);
        calculateTotal();
        logger.d('Menu removed: $menuId');
      }
    } catch (e) {
      logger.e('Error in removeMenu: $e');
    }
  }

  void addMenusFromOrder(List<Map<String, dynamic>> menus) {
    try {
      logger.d('Adding menus from order: $menus');
      var box = Hive.box('orders');
      for (var menu in menus) {
        // Ensure the price is correctly set
        menu['harga'] = int.parse(menu['harga'].toString());
        menuList.add(menu);
        box.add(menu);
      }
      calculateTotal();
      logger.d('Menus added from order');
    } catch (e) {
      logger.e('Error in addMenusFromOrder: $e');
    }
  }
}