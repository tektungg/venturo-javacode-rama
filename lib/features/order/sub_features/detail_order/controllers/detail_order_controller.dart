import 'dart:async';

import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/order/repositories/order_repository.dart';

class DetailOrderController extends GetxController {
  static DetailOrderController get to => Get.find<DetailOrderController>();

  late final OrderRepository _orderRepository;

  // order data
  RxString orderDetailState = 'loading'.obs;
  Rxn<Map<String, dynamic>> order = Rxn();

  Timer? timer;
  
  @override
  void onInit() {
    super.onInit();
    
    _orderRepository = OrderRepository();
    final orderId = int.parse(Get.parameters['orderId'] as String);

    getOrderDetail(orderId).then((value) {
      timer = Timer.periodic(
        const Duration(seconds: 10),
        (_) => getOrderDetail(orderId, isPeriodic: true),
      );
    });
  }


  @override
  void onClose() {
    timer?.cancel();

    super.onClose();
  }


  Future<void> getOrderDetail(int orderId, {bool isPeriodic = false}) async {
    if (!isPeriodic) {

      orderDetailState('loading');
    }

    try {
      final result = _orderRepository.getOrderDetail(orderId);

      orderDetailState('success');
      order(result);
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      orderDetailState('error');
    }
  }


  List<Map<String, dynamic>> get foodItems =>
      order.value?['menu']
          .where((element) => element['kategori'] == 'makanan')
          .toList() ??
      [];

  List<Map<String, dynamic>> get drinkItems =>
      order.value?['menu']
          .where((element) => element['kategori'] == 'minuman')
          .toList() ??
      [];
}