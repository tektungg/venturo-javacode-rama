import 'package:get/get.dart';
import 'package:logger/logger.dart';

class VoucherController extends GetxController {
  static VoucherController get to => Get.find();

  final Rx<Map<String, dynamic>?> selectedVoucher = Rx<Map<String, dynamic>?>(null);
  final Logger logger = Logger();

  void selectVoucher(Map<String, dynamic> voucher) {
    try {
      if (selectedVoucher.value != null && selectedVoucher.value!['id_voucher'] == voucher['id_voucher']) {
        selectedVoucher.value = null;
        logger.d('Voucher deselected');
      } else {
        selectedVoucher.value = voucher;
        logger.d('Voucher selected: ${voucher['nominal']}');
      }
    } catch (e) {
      logger.e('Error in selectVoucher');
    }
  }

  int get totalVoucherNominal {
    try {
      return selectedVoucher.value != null ? selectedVoucher.value!['nominal'] as int : 0;
    } catch (e) {
      logger.e('Error in totalVoucherNominal');
      return 0;
    }
  }

  int? get selectedVoucherId {
    return selectedVoucher.value?['id_voucher'] as int?;
  }
}