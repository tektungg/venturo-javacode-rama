import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/repositories/detail_menu_repository.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();

  final RxList<Map<String, dynamic>> menuList = <Map<String, dynamic>>[].obs;
  final RxInt totalHarga = 0.obs;
  final RxInt totalPembayaran = 0.obs;
  final RxInt totalMenuDipesan = 0.obs;
  final RxInt totalVoucherNominal = 0.obs;
  final Rx<Map<String, dynamic>?> selectedVoucher =
      Rx<Map<String, dynamic>?>(null);

  final DetailMenuRepository detailMenuRepository = DetailMenuRepository();

  @override
  void onInit() {
    super.onInit();
    // Fetch menu list and calculate total price
    fetchMenuDetails();
    calculateTotal();
  }

  void fetchMenuDetails() async {
    for (var menu in menuList) {
      var menuDetail =
          await detailMenuRepository.fetchMenuDetail(menu['id_menu']);
      menu['foto'] = menuDetail['foto'];
    }
    menuList.refresh();
  }

  void calculateTotal() {
    int total = 0;
    int totalItems = 0;
    for (var menu in menuList) {
      total += (menu['harga'] as int) * (menu['jumlah'] as int);
      totalItems += menu['jumlah'] as int;
    }
    totalHarga.value = total;
    totalPembayaran.value =
        (total - totalVoucherNominal.value).clamp(10000, total);
    totalMenuDipesan.value = totalItems;
  }

  void applyVoucher(Map<String, dynamic> voucher) {
    selectedVoucher.value = voucher;
    totalVoucherNominal.value = voucher['nominal'] as int;
    calculateTotal();
  }

  Map<String, List<Map<String, dynamic>>> get groupedMenuByCategory {
    Map<String, List<Map<String, dynamic>>> groupedMenu = {};
    for (var menu in menuList) {
      String category = menu['kategori'] ?? 'Lainnya';
      if (!groupedMenu.containsKey(category)) {
        groupedMenu[category] = [];
      }
      groupedMenu[category]!.add(menu);
    }
    return groupedMenu;
  }

  void updateMenu(Map<String, dynamic> updatedMenu) {
    int index = menuList
        .indexWhere((menu) => menu['id_menu'] == updatedMenu['id_menu']);
    if (index != -1) {
      menuList[index] = updatedMenu;
      calculateTotal();
    }
  }
}
