import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/features/order/repositories/order_repository.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find<OrderController>();
  late final OrderRepository _orderRepository;

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
      final result = _orderRepository.getOngoingOrder();
      final data = result.where((element) => element['status'] != 4).toList();
      onGoingOrders(data.reversed.toList());

      onGoingOrderState('success');
    } catch (exception, stacktrace) {
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
      final result = _orderRepository.getOrderHistory();
      historyOrders(result.reversed.toList());

      orderHistoryState('success');
    } catch (exception, stacktrace) {
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
      historyOrderList.removeWhere((element) => element['status'] != 3);
    } else if (selectedCategory.value == 'completed') {
      historyOrderList.removeWhere((element) => element['status'] != 4);
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
}
