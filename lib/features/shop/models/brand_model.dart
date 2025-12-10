class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// Convert model to Json structure
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'products_count': productsCount,
      'is_featured': isFeatured,
    };
  }

  /// Map Json from Supabase to BrandModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      isFeatured: data['is_featured'] ?? false,
      productsCount: int.parse((data['products_count'] ?? 0).toString()),
    );
  }
}
