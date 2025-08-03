import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'series_item.g.dart';

/// Elemento de Serie
@collection
class SeriesItem extends Equatable {
  Id id = Isar.autoIncrement;
  
  @Index()
  final int seriesId;
  final String name;
  final String cover;
  final String plot;
  final String cast;
  final String director;
  final String genre;
  final DateTime? releaseDate;
  final double rating;
  final int categoryId;
  final int episodeRunTime;
  
  // Cache TTL
  final DateTime cacheExpiry;

  const SeriesItem({
    required this.seriesId,
    required this.name,
    required this.cover,
    required this.plot,
    required this.cast,
    required this.director,
    required this.genre,
    this.releaseDate,
    required this.rating,
    required this.categoryId,
    required this.episodeRunTime,
    required this.cacheExpiry,
  });

  factory SeriesItem.fromJson(Map<String, dynamic> json) {
    return SeriesItem(
      seriesId: int.parse(json['series_id'].toString()),
      name: json['name'] as String,
      cover: json['cover'] as String? ?? '',
      plot: json['plot'] as String? ?? '',
      cast: json['cast'] as String? ?? '',
      director: json['director'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      releaseDate: json['release_date'] != null 
          ? DateTime.tryParse(json['release_date'].toString())
          : null,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      categoryId: int.parse(json['category_id'].toString()),
      episodeRunTime: int.tryParse(json['episode_run_time'].toString()) ?? 0,
      cacheExpiry: DateTime.now().add(const Duration(hours: 6)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'series_id': seriesId,
      'name': name,
      'cover': cover,
      'plot': plot,
      'cast': cast,
      'director': director,
      'genre': genre,
      'release_date': releaseDate?.toIso8601String(),
      'rating': rating,
      'category_id': categoryId,
      'episode_run_time': episodeRunTime,
    };
  }

  SeriesItem copyWith({
    int? seriesId,
    String? name,
    String? cover,
    String? plot,
    String? cast,
    String? director,
    String? genre,
    DateTime? releaseDate,
    double? rating,
    int? categoryId,
    int? episodeRunTime,
    DateTime? cacheExpiry,
  }) {
    return SeriesItem(
      seriesId: seriesId ?? this.seriesId,
      name: name ?? this.name,
      cover: cover ?? this.cover,
      plot: plot ?? this.plot,
      cast: cast ?? this.cast,
      director: director ?? this.director,
      genre: genre ?? this.genre,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      categoryId: categoryId ?? this.categoryId,
      episodeRunTime: episodeRunTime ?? this.episodeRunTime,
      cacheExpiry: cacheExpiry ?? this.cacheExpiry,
    );
  }

  @override
  @ignore
  List<Object?> get props => [
        seriesId,
        name,
        cover,
        plot,
        cast,
        director,
        genre,
        releaseDate,
        rating,
        categoryId,
        episodeRunTime,
      ];
}