import 'package:isar/isar.dart';

part 'vod_item.g.dart';

/// Elemento de Video on Demand
@collection
class VodItem {
  Id id = Isar.autoIncrement;

  @Index()
  final int streamId;
  final String name;
  final String streamIcon;
  final String plot;
  final String director;
  final String cast;
  final String genre;
  final DateTime? releaseDate;
  final double rating;
  final int categoryId;
  final String containerExtension;

  // Cache TTL
  final DateTime cacheExpiry;

  // No const: Isar id is not final
  VodItem({
    required this.streamId,
    required this.name,
    required this.streamIcon,
    required this.plot,
    required this.director,
    required this.cast,
    required this.genre,
    this.releaseDate,
    required this.rating,
    required this.categoryId,
    required this.containerExtension,
    required this.cacheExpiry,
  });

  factory VodItem.fromJson(Map<String, dynamic> json) {
    return VodItem(
      streamId: int.parse(json['stream_id'].toString()),
      name: json['name'] as String,
      streamIcon: json['stream_icon'] as String? ?? '',
      plot: json['plot'] as String? ?? '',
      director: json['director'] as String? ?? '',
      cast: json['cast'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      releaseDate: json['release_date'] != null 
          ? DateTime.tryParse(json['release_date'].toString())
          : null,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      categoryId: int.parse(json['category_id'].toString()),
      containerExtension: json['container_extension'] as String? ?? 'mp4',
      cacheExpiry: DateTime.now().add(const Duration(hours: 6)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stream_id': streamId,
      'name': name,
      'stream_icon': streamIcon,
      'plot': plot,
      'director': director,
      'cast': cast,
      'genre': genre,
      'release_date': releaseDate?.toIso8601String(),
      'rating': rating,
      'category_id': categoryId,
      'container_extension': containerExtension,
    };
  }

  VodItem copyWith({
    int? streamId,
    String? name,
    String? streamIcon,
    String? plot,
    String? director,
    String? cast,
    String? genre,
    DateTime? releaseDate,
    double? rating,
    int? categoryId,
    String? containerExtension,
    DateTime? cacheExpiry,
  }) {
    return VodItem(
      streamId: streamId ?? this.streamId,
      name: name ?? this.name,
      streamIcon: streamIcon ?? this.streamIcon,
      plot: plot ?? this.plot,
      director: director ?? this.director,
      cast: cast ?? this.cast,
      genre: genre ?? this.genre,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      categoryId: categoryId ?? this.categoryId,
      containerExtension: containerExtension ?? this.containerExtension,
      cacheExpiry: cacheExpiry ?? this.cacheExpiry,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VodItem && other.streamId == streamId;
  }

  @override
  int get hashCode => streamId.hashCode;

  @ignore
  List<Object?> get props => [streamId, name, streamIcon, plot, director, cast, genre, releaseDate, rating, categoryId, containerExtension, cacheExpiry];
}