
class PromoModel {
  String id;
  String code;
  double discountPercent;
  DateTime startDate;
  DateTime endDate;
  String? reason;
  bool isActive;

  PromoModel({
    required this.id,
    required this.code,
    required this.discountPercent,
    required this.startDate,
    required this.endDate,
    this.reason,
    required this.isActive,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      id: json['id'] as String,
      code: json['code'] as String,
      discountPercent: (json['discount_percent'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      reason: json['reason'] as String?,
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount_percent': discountPercent,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'reason': reason,
      'is_active': isActive,
    };
  }
}
