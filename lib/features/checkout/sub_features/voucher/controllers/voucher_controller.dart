import 'package:get/get.dart';

class VoucherController extends GetxController {
  static VoucherController get to => Get.find();

  final Rx<Map<String, dynamic>?> selectedVoucher = Rx<Map<String, dynamic>?>(null);

  void selectVoucher(Map<String, dynamic> voucher) {
    if (selectedVoucher.value == voucher) {
      selectedVoucher.value = null;
    } else {
      selectedVoucher.value = voucher;
    }
  }

  int get totalVoucherNominal {
    return selectedVoucher.value != null ? selectedVoucher.value!['nominal'] as int : 0;
  }
}