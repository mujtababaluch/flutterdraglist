import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReorderableListScreen extends StatefulWidget {
  const ReorderableListScreen({super.key});

  @override
  _ReorderableListScreenState createState() => _ReorderableListScreenState();
}

class _ReorderableListScreenState extends State<ReorderableListScreen> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  List<String> _items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"];

  @override
  void initState() {
    super.initState();
    _loadSavedOrder();
  }

  // Load saved order from storage
  Future<void> _loadSavedOrder() async {
    String? savedOrder = await _storage.read(key: 'order_list');
    if (savedOrder != null) {
      setState(() {
        _items = List<String>.from(json.decode(savedOrder));
      });
    }
  }

  // Save order to storage
  Future<void> _saveOrder() async {
    await _storage.write(key: 'order_list', value: json.encode(_items));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Draggable List")),
      body: ReorderableListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            key: ValueKey(item), // Ensure each item has a unique key
            title: Text(item),
            tileColor: Colors.grey[200],
            leading: Icon(Icons.drag_handle),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
          _saveOrder();
        },
      ),
    );
  }
}