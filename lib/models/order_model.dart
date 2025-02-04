class Order {
  final int id;
  final String title;
   bool isRead;

  Order({required this.id, required this.title,this.isRead = false});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      title: json['title'],
      isRead: json["isRead"] ?? false
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        "isRead": isRead
      };
}
