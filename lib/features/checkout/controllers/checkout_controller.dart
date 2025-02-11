import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();

  final RxList<Map<String, dynamic>> menuList = <Map<String, dynamic>>[].obs;
  final RxInt totalHarga = 0.obs;
  final RxInt totalPembayaran = 0.obs;
  final RxInt totalMenuDipesan = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch menu list and calculate total price
    fetchMenuList();
  }

  void fetchMenuList() {
    // Dummy data for illustration
    menuList.assignAll([
      {'nama': 'Makanan 1', 'harga': 10000, 'jumlah': 2},
      {'nama': 'Minuman 1', 'harga': 5000, 'jumlah': 1},
      {'nama': 'Snack 1', 'harga': 7000, 'jumlah': 3},
    ]);

    calculateTotal();
  }

  void calculateTotal() {
    int total = 0;
    int totalItems = 0;
    for (var menu in menuList) {
      total += (menu['harga'] as int) * (menu['jumlah'] as int);
      totalItems += menu['jumlah'] as int;
    }
    totalHarga.value = total;
    totalPembayaran.value = total; // Update this with discount and voucher logic
    totalMenuDipesan.value = totalItems;
  }
}