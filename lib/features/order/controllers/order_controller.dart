import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/order/repositories/order_repository.dart';
import 'package:venturo_core/features/checkout/controllers/checkout_controller.dart';
import 'package:venturo_core/features/order/sub_features/detail_order/controllers/detail_order_controller.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.put(OrderController());
  late final OrderRepository _orderRepository;
  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();

    _orderRepository = OrderRepository();

    getOngoingOrders();
    getOrderHistories();
  }

  RxList<Map<String, dynamic>> onGoingOrders = RxList();
  RxList<Map<String, dynamic>> historyOrders = RxList();

  RxString onGoingOrderState = 'loading'.obs;
  RxString orderHistoryState = 'loading'.obs;

  Rx<String> selectedCategory = 'all'.obs;

  Map<String, String> get dateFilterStatus => {
        'all': 'Semua'.tr,
        'completed': 'Selesai'.tr,
        'canceled': 'Dibatalkan'.tr,
      };

  Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);

  Future<void> getOngoingOrders() async {
    onGoingOrderState('loading');

    try {
      final userId = Hive.box('venturo').get('userId');
      logger.d('Fetching ongoing orders for user ID: $userId');
      final result = await _orderRepository.getOngoingOrder(userId);
      logger.d('Ongoing orders fetched successfully: $result');
      onGoingOrders(result.reversed.toList());

      onGoingOrderState('success');
    } catch (exception, stacktrace) {
      logger.e('Failed to fetch ongoing orders: $exception');
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      onGoingOrderState('error');
    }
  }

  Future<void> getOrderHistories() async {
    orderHistoryState('loading');

    try {
      final userId = Hive.box('venturo').get('userId');
      logger.d('Fetching order histories for user ID: $userId');
      final result = await _orderRepository.getOrderHistory(userId);
      logger.d('Order histories fetched successfully: $result');
      historyOrders(result.reversed.toList());

      orderHistoryState('success');
    } catch (exception, stacktrace) {
      logger.e('Failed to fetch order histories: $exception');
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      orderHistoryState('error');
    }
  }

  void setDateFilter({String? category, DateTimeRange? range}) {
    selectedCategory(category ?? 'all');
    selectedDateRange(range);
  }

  List<Map<String, dynamic>> get filteredHistoryOrder {
    final historyOrderList = historyOrders.toList();

    if (selectedCategory.value == 'canceled') {
      historyOrderList.removeWhere((element) => element['status'] != 4);
    } else if (selectedCategory.value == 'completed') {
      historyOrderList.removeWhere((element) => element['status'] != 3);
    }

    if (selectedDateRange.value != null) {
      historyOrderList.removeWhere((element) =>
          DateTime.parse(element['tanggal'] as String)
              .isBefore(selectedDateRange.value!.start) ||
          DateTime.parse(element['tanggal'] as String)
              .isAfter(selectedDateRange.value!.end));
    }

    historyOrderList.sort((a, b) => DateTime.parse(b['tanggal'] as String)
        .compareTo(DateTime.parse(a['tanggal'] as String)));

    return historyOrderList;
  }

  String get totalHistoryOrder {
    final total = filteredHistoryOrder.where((e) => e['status'] == 3).fold(
        0,
        (previousValue, element) =>
            previousValue + (element['total_bayar'] as int));
    return total.toString();
  }

  Future<void> createOrder() async {
    try {
      final userId = Hive.box('venturo').get('userId');
      final checkoutController = CheckoutController.to;

      final orderData = {
        "order": {
          "id_user": userId,
          "id_voucher": checkoutController.selectedVoucher.value?['id_voucher'],
          "potongan": checkoutController.totalVoucherNominal.value +
              checkoutController.totalDiskonNominal.value,
          "total_bayar": checkoutController.totalPembayaran.value
        },
        "menu": checkoutController.menuList.map((menu) {
          return {
            "id_menu": menu['id_menu'],
            "harga": menu['harga'],
            "level": menu['level'],
            "topping": menu['toppings'] ?? [],
            "jumlah": menu['jumlah'],
            "catatan": menu['catatan'] ?? '',
          };
        }).toList()
      };

      logger.d('Order data: $orderData');

      await _orderRepository.createOrder(orderData);
      logger.d('Order created successfully');

      // Clear orders from Hive box
      var box = Hive.box('orders');
      await box.clear();
      checkoutController.menuList.clear();
      checkoutController.calculateTotal();
      logger.d('Orders cleared from Hive');
    } catch (e) {
      logger.e('Error in createOrder: $e');
      rethrow;
    }
  }

  Future<void> cancelOrder(int orderId) async {
    try {
      await _orderRepository.cancelOrder(orderId);
      logger.d('Order canceled successfully');
      await getOngoingOrders();
      await getOrderHistories();

      final userId = Hive.box('venturo').get('userId');
      await DetailOrderController.to.getOrderDetail(orderId, userId);
    } catch (e) {
      logger.e('Error in cancelOrder: $e');
      rethrow;
    }
  }
}
