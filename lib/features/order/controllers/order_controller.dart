import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();

  final RxString selectedTab = 'Sedang Berjalan'.obs;
  final RxList<Map<String, dynamic>> ongoingOrders =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> orderHistory =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch ongoing orders and order history
    fetchOrders();
  }

  void fetchOrders() {
    // Dummy data for illustration
    ongoingOrders.assignAll([
      {'nama': 'Makanan 1', 'harga': 10000, 'jumlah': 2},
      {'nama': 'Minuman 1', 'harga': 5000, 'jumlah': 1},
    ]);

    orderHistory.assignAll([
      {'nama': 'Snack 1', 'harga': 7000, 'jumlah': 3},
    ]);
  }
}
