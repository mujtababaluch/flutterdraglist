import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';
import '../models/order_model.dart';

class OrderListScreen extends StatelessWidget {
  final OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
             controller.markAllAsRead();
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
             
            },
          ),
        ],
        ),
      body: Obx(() {
        return ReorderableListView.builder(
          itemCount: controller.orders.length,
          onReorder: (oldIndex, newIndex) {
            controller.updateOrderSequence(oldIndex, newIndex);
          },
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return Card(
              key: ValueKey(order.id),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                title: Text(order.title),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("3:00 PM", style: TextStyle(fontWeight: FontWeight.bold)), 
                    Obx(() => Text(controller.remainingTime.value, style: const TextStyle(color: Colors.red))),
                  ],
                ),
                tileColor: Colors.white,
                trailing: order.isRead
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.mark_as_unread, color: Colors.red),
              ),
            );
          },
        );
      }),
    );
  }
}
