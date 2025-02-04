class Order {
  final int id;
  final String pickupLocation;
  final String dropoffLocation;
  
  Order({required this.id, required this.pickupLocation, required this.dropoffLocation});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      pickupLocation: json['pickup'],
      dropoffLocation: json['dropoff'],
    );
  }
}
