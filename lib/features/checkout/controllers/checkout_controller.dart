import 'package:get/get.dart';
import 'package:venturo_core/features/detail_menu/repositories/detail_menu_repository.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();

  final RxList<Map<String, dynamic>> menuList = <Map<String, dynamic>>[].obs;
  final RxInt totalHarga = 0.obs;
  final RxInt totalPembayaran = 0.obs;
  final RxInt totalMenuDipesan = 0.obs;

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
      menu['foto'] = menuDetail['foto']; // Pastikan properti foto diatur
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
        total; // Update this with discount and voucher logic
    totalMenuDipesan.value = totalItems;
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
}
