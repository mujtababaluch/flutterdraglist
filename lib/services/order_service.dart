import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_model.dart';

class OrderService {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.take(5).map((e) => Order.fromJson(e)).toList(); // Taking first 5 for demo
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
