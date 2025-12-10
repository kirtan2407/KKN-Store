class BannerModel {
  String id;
  String imageUrl;
  String targetScreen;
  bool active;

  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  factory BannerModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    return BannerModel(
      id: data['id'] ?? '',
      imageUrl: data['image_url'] ?? '',
      targetScreen: data['target_screen'] ?? '',
      active: data['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'target_screen': targetScreen,
      'active': active,
    };
  }
}
