import 'package:get/get.dart';

class VoucherController extends GetxController {
  static VoucherController get to => Get.find();

  final RxList<Map<String, dynamic>> selectedVouchers =
      <Map<String, dynamic>>[].obs;

  void toggleVoucher(Map<String, dynamic> voucher) {
    if (selectedVouchers.contains(voucher)) {
      selectedVouchers.remove(voucher);
    } else {
      selectedVouchers.add(voucher);
    }
  }

  int get totalVoucherNominal {
    return selectedVouchers.fold<int>(
        0, (sum, voucher) => sum + (voucher['nominal'] as int));
  }
}
