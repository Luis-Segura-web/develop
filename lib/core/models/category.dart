import 'package:equatable/equatable.dart';

/// Modelo de categoría de canales o VOD
class Category extends Equatable {
  final String categoryId;
  final String categoryName;

  const Category({
    required this.categoryId,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id']?.toString() ?? '',
      categoryName: json['category_name']?.toString() ?? '',
    );
  }

  @override
  List<Object> get props => [categoryId, categoryName];
}
