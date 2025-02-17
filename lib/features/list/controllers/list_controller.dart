import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_core/configs/routes/route.dart';
import 'package:venturo_core/features/get_location/controllers/get_location_controller.dart';
import 'package:venturo_core/features/list/repositories/list_repository.dart';

class ListController extends GetxController {
  static ListController get to => Get.find<ListController>();

  late final ListRepository repository;

  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> selectedItems = <Map<String, dynamic>>[].obs;
  final RxString selectedCategory = 'Semua'.obs;
  final RxString keyword = ''.obs;

  final List<String> categories = [
    'Semua',
    'Makanan',
    'Minuman',
    'Snack',
  ];

  late RefreshController refreshController;
  final Logger logger = Logger();

  @override
  void onInit() async {
    super.onInit();

    refreshController = RefreshController(initialRefresh: false);

    try {
      await _checkLocationPermissionAndGetLocation();
      repository = ListRepository();
      await getListOfData();
    } catch (e) {
      logger.e('Error in ListController onInit');
    }
  }

  Future<void> _checkLocationPermissionAndGetLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Get.toNamed(Routes.getLocationRoute);
      } else {
        if (!GetLocationController.to.locationObtained) {
          _initializeGetLocationController();
        }
      }
    } catch (e) {
      logger.e('Error in _checkLocationPermissionAndGetLocation');
    }
  }

  void _initializeGetLocationController() {
    try {
      if (!Get.isRegistered<GetLocationController>()) {
        Get.put(GetLocationController());
      }
      GetLocationController.to.getLocation();
    } catch (e) {
      logger.e('Error in _initializeGetLocationController');
    }
  }

  void onRefresh() async {
    try {
      final result = await getListOfData();

      if (result) {
        refreshController.refreshCompleted();
      } else {
        refreshController.refreshFailed();
      }
    } catch (e) {
      logger.e('Error in onRefresh');
      refreshController.refreshFailed();
    }
  }

  List<Map<String, dynamic>> get filteredList => items
      .where((element) =>
          element['nama']
              .toString()
              .toLowerCase()
              .contains(keyword.value.toLowerCase()) &&
          (selectedCategory.value == 'Semua' ||
              element['kategori'].toString().toLowerCase() ==
                  selectedCategory.value.toLowerCase()))
      .toList();

  List<Map<String, dynamic>> get makananList => items
      .where((element) =>
          element['kategori'].toString().toLowerCase() == 'makanan')
      .toList();

  List<Map<String, dynamic>> get minumanList => items
      .where((element) =>
          element['kategori'].toString().toLowerCase() == 'minuman')
      .toList();

  List<Map<String, dynamic>> get snackList => items
      .where(
          (element) => element['kategori'].toString().toLowerCase() == 'snack')
      .toList();

  Future<bool> getListOfData() async {
    try {
      final result = await repository.getListOfData(
        category: selectedCategory.value.toLowerCase(),
      );

      items.assignAll(result);
      refreshController.loadComplete();

      return true;
    } catch (exception, stacktrace) {
      logger.e('Error in getListOfData');
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );

      refreshController.loadFailed();
      return false;
    }
  }

  Future<void> deleteItem(Map<String, dynamic> item) async {
    try {
      await repository.deleteItem(item['id_menu']);

      items.remove(item);
      selectedItems.remove(item);
    } catch (exception, stacktrace) {
      logger.e('Error in deleteItem');
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
    }
  }
}