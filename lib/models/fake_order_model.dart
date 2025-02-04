class FakeOrder {
  final int id;
  final String pickupLocation;
  final String dropoffLocation;
  FakeOrder ({required this.id, required this.pickupLocation, required this.dropoffLocation});

  factory FakeOrder .fromJson(Map<String, dynamic> json) {
    return FakeOrder (
      id: json['id'],
      pickupLocation: json['title'],
      dropoffLocation: json['dropoff'],
    );
  }
}
