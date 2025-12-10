import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(id: '', image: '', name: '', isFeatured: false);

  /// Convert model to Json structure so that you can store data in Supabase
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'parent_id': parentId,
      'is_featured': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from Supabase to UserModel
  factory CategoryModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return CategoryModel.empty();
    return CategoryModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      parentId: data['parent_id'] ?? '',
      isFeatured: data['is_featured'] ?? false,
    );
  }
}
