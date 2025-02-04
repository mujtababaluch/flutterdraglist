import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class MyOrders extends StatelessWidget {
      final OrderController controller = Get.put(OrderController());
   MyOrders({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.myorders[index];
            return ListTile(
              title: Text("Order ID: ${order.id}"),
              subtitle: Text("Pickup: ${order.pickupLocation} → Dropoff: ${order.dropoffLocation}"),
            );
          },
        );
      }),
    );
  }
}