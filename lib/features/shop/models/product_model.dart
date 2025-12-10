import 'package:kkn_store/features/shop/models/brand_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  // List<ProductAttributeModel>? productAttributes; // Future use
  // List<ProductVariationModel>? productVariations; // Future use

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    this.sku,
    this.date,
    this.salePrice = 0.0,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.images,
    this.productType = 'single',
    // this.productAttributes,
    // this.productVariations,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '');

  /// Json Format
  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'title': title,
      'stock': stock,
      'price': price,
      'images': images ?? [],
      'thumbnail': thumbnail,
      'sale_price': salePrice,
      'is_featured': isFeatured,
      'category_id': categoryId,
      'brand_id': brand?.id,
      'description': description,
      'product_type': productType,
      // 'product_attributes': productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
      // 'product_variations': productVariations != null ? productVariations!.map((e) => e.toJson()).toList() : [],
    };
  }

  /// Map Json from Supabase to Model
  factory ProductModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductModel.empty();
    return ProductModel(
      id: data['id'] ?? '',
      sku: data['sku'],
      title: data['title'] ?? '',
      stock: data['stock'] ?? 0,
      isFeatured: data['is_featured'] ?? false,
      price: double.parse((data['price'] ?? 0.0).toString()),
      salePrice: double.parse((data['sale_price'] ?? 0.0).toString()),
      thumbnail: data['thumbnail'] ?? '',
      categoryId: data['category_id'],
      description: data['description'],
      productType: data['product_type'] ?? 'single',
      brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,
      images: data['images'] != null ? List<String>.from(data['images']) : [],
      // productAttributes: (data['product_attributes'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
      // productVariations: (data['product_variations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),
    );
  }
}
