import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class OrderRepository {
  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
