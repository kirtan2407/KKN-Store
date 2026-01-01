class ReviewModel {
  String id;
  String userId;
  String productId;
  double rating;
  String? comment;
  DateTime createdAt;
  String? userName; // fetched via join or separate query
  String? userImage; // fetched via join or separate query

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

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'product_id': productId,
      'rating': rating,
      'comment': comment,
      // 'created_at': createdAt.toIso8601String(), // Usually server sets this
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profiles'];
    String? name;
    String? image;

    if (profile != null) {
      if (profile is Map) {
        name = profile['full_name'];
        image = profile['avatar_url'];
      } else if (profile is List && profile.isNotEmpty) {
        name = profile[0]['full_name'];
        image = profile[0]['avatar_url'];
      }
    }

    return ReviewModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      productId: json['product_id'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      createdAt:
          DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now(),
      userName: name,
      userImage: image,
    );
  }
}
