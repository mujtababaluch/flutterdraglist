import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/order_model.dart';

class SecureStorageService {
  static const String key = 'saved_order_sequence';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveOrderSequence(List<Order> orders) async {
    String encodedData = json.encode(orders.map((e) => e.toJson()).toList());
    await _storage.write(key: key, value: encodedData);
  }

  Future<List<Order>?> getOrderSequence() async {
    String? storedData = await _storage.read(key: key);
    if (storedData != null) {
      List<dynamic> jsonList = json.decode(storedData);
      return jsonList.map((e) => Order.fromJson(e)).toList();
    }
    return null;
  }
}
