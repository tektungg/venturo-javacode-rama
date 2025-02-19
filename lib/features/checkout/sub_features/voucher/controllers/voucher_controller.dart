import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';

class VoucherController extends GetxController {
  static VoucherController get to => Get.find();

  final Rx<Map<String, dynamic>?> selectedVoucher = Rx<Map<String, dynamic>?>(null);
  final Logger logger = Logger();

  void selectVoucher(Map<String, dynamic> voucher) {
    try {
      if (selectedVoucher.value != null && selectedVoucher.value!['id_voucher'] == voucher['id_voucher']) {
        selectedVoucher.value = null;
        logger.d('Voucher deselected');
        CheckoutController.to.applyVoucher(null); // Apply null voucher to restore discounts
      } else {
        selectedVoucher.value = voucher;
        logger.d('Voucher selected: ${voucher['nominal']}');
        CheckoutController.to.applyVoucher(voucher); // Apply selected voucher
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