class TransactionModel {
  final String id;
  final String orderId;
  final double amount;
  final String type; // 'Credit' or 'Debit'
  final String category;
  final String description;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.type,
    required this.category,
    required this.description,
    required this.date,
  });

  static TransactionModel empty() => TransactionModel(id: '', orderId: '', amount: 0, type: '', category: '', description: '', date: DateTime.now());

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      orderId: json['order_id'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.tryParse(json['transaction_date'] ?? '') ?? DateTime.now(),
    );
  }
}
