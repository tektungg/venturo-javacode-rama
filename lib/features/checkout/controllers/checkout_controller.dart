import 'package:get/get.dart';
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
      fetchMenuDetails();
    } catch (e) {
      logger.e('Error in CheckoutController onInit');
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
      logger.e('Error in fetchMenuDetails');
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
      logger.e('Error in calculateTotal');
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
      logger.e('Error in calculateTotalDiscount');
    }
  }

  void applyVoucher(Map<String, dynamic>? voucher) {
    try {
      if (voucher == null || voucher.isEmpty) {
        logger.d('Removing voucher');
        selectedVoucher.value = null;
        totalVoucherNominal.value = 0;
      } else {
        logger.d('Applying voucher: ${voucher['nominal']}');
        selectedVoucher.value = voucher;
        totalVoucherNominal.value = voucher['nominal'] as int;
      }
      calculateTotal();
    } catch (e) {
      logger.e('Error in applyVoucher');
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
      logger.e('Error in groupedMenuByCategory');
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
        calculateTotal();
      }
    } catch (e) {
      logger.e('Error in updateMenu');
    }
  }
}