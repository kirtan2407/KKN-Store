class ReviewModel {
  String id;
  String userId;
  String productId;
  double rating;
  String? comment;
  DateTime createdAt;
  String? userName; // For display
  String? userImage; // For display

  ReviewModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    this.comment,
    required this.createdAt,
    this.userName,
    this.userImage,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      userName: json['profiles'] != null ? json['profiles']['full_name'] : 'Anonymous',
      userImage: json['profiles'] != null ? json['profiles']['avatar_url'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
