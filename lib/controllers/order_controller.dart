import 'dart:async';
import 'package:get/get.dart';
import '../models/fake_order_model.dart';
import '../models/order_model.dart';
import '../services/order_repository.dart';
import '../services/order_service.dart';
import '../services/secure_storage_service.dart';

class OrderController extends GetxController {
  var orders = <Order>[].obs;
   var myorders = <FakeOrder>[].obs;
  final OrderService _orderService = OrderService();
  final SecureStorageService _storageService = SecureStorageService();
    final OrderRepository _repository = OrderRepository();

  
  RxString remainingTime = "".obs; // Global countdown for all orders
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    ///loadOrders();
      fetchOrders();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateRemainingTime();
    });
  }

  void updateRemainingTime() {
    final now = DateTime.now();
    final delivery = DateTime(now.year, now.month, now.day, 15, 00); 

    Duration difference = delivery.difference(now);

    if (difference.isNegative) {
      remainingTime.value = "Time Passed";
    } else {
      int totalMinutes = difference.inMinutes; 
      remainingTime.value = "$totalMinutes min left";
    }
  }
 void markAllAsRead() {
    for (var order in orders) {
      order.isRead = true;
    }
    orders.refresh(); // ✅ UI Update
    _storageService.saveOrderSequence(orders); // ✅ Save permanently
  }
  
  Future<void> loadOrders() async {
    List<Order>? savedOrders = await _storageService.getOrderSequence();
    if (savedOrders != null) {
      orders.assignAll(savedOrders);
    } else {
      List<Order> fetchedOrders = await _orderService.fetchOrders();
      orders.assignAll(fetchedOrders);
      await _storageService.saveOrderSequence(fetchedOrders);
    }
  }

  void updateOrderSequence(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    List<Order> updatedOrders = List.from(orders);

    final Order movedOrder = updatedOrders.removeAt(oldIndex);
    updatedOrders.insert(newIndex, movedOrder);

    orders.assignAll(updatedOrders);
    _storageService.saveOrderSequence(updatedOrders);
  }


  void fetchOrders() async {
    try {
      var fetchedOrders = await _repository.fetchOrders();
      myorders.assignAll(fetchedOrders);
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
