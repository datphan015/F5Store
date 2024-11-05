class Payment {
  final String id;
  final String orderId;
  final double amount;
  final String method;
  final String status;
  final DateTime datePayment;

  Payment({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.method,
    required this.status,
    required this.datePayment,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['_id'],
      orderId: json['orderId'],
      amount: json['amount'].toDouble(),
      method: json['method'],
      status: json['status'],
      datePayment: DateTime.parse(json['datePayment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'amount': amount,
      'method': method,
      'status': status,
      'datePayment': datePayment.toIso8601String(),
    };
  }
}
