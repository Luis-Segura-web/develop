import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String categoryId;
  final String categoryName;
  final String? parentId;

  const CategoryModel({
    required this.categoryId,
    required this.categoryName,
    this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id']?.toString() ?? '',
      categoryName: json['category_name'] as String? ?? '',
      parentId: json['parent_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'parent_id': parentId,
    };
  }

  CategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    String? parentId,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      parentId: parentId ?? this.parentId,
    );
  }

  String get displayName => categoryName.isNotEmpty ? categoryName : 'Categoría sin nombre';

  @override
  List<Object?> get props => [categoryId, categoryName, parentId];
}

class VodModel extends Equatable {
  final String streamId;
  final String name;
  final String? streamIcon;
  final String? rating;
  final String? year;
  final String? genre;
  final String? plot;
  final String? cast;
  final String? director;
  final String? releasedate;
  final String? duration;
  final String? country;
  final String? trailer;
  final String? categoryId;
  final String? containerExtension;
  final String? added;
  final double? rating5based;
  final double? ratingImdb;

  const VodModel({
    required this.streamId,
    required this.name,
    this.streamIcon,
    this.rating,
    this.year,
    this.genre,
    this.plot,
    this.cast,
    this.director,
    this.releasedate,
    this.duration,
    this.country,
    this.trailer,
    this.categoryId,
    this.containerExtension,
    this.added,
    this.rating5based,
    this.ratingImdb,
  });

  factory VodModel.fromJson(Map<String, dynamic> json) {
    return VodModel(
      streamId: json['stream_id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      streamIcon: json['stream_icon'] as String?,
      rating: json['rating'] as String?,
      year: json['year'] as String?,
      genre: json['genre'] as String?,
      plot: json['plot'] as String?,
      cast: json['cast'] as String?,
      director: json['director'] as String?,
      releasedate: json['releasedate'] as String?,
      duration: json['duration'] as String?,
      country: json['country'] as String?,
      trailer: json['trailer'] as String?,
      categoryId: json['category_id']?.toString(),
      containerExtension: json['container_extension'] as String?,
      added: json['added'] as String?,
      rating5based: (json['rating_5based'] as num?)?.toDouble(),
      ratingImdb: (json['rating_imdb'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stream_id': streamId,
      'name': name,
      'stream_icon': streamIcon,
      'rating': rating,
      'year': year,
      'genre': genre,
      'plot': plot,
      'cast': cast,
      'director': director,
      'releasedate': releasedate,
      'duration': duration,
      'country': country,
      'trailer': trailer,
      'category_id': categoryId,
      'container_extension': containerExtension,
      'added': added,
      'rating_5based': rating5based,
      'rating_imdb': ratingImdb,
    };
  }

  String get displayName => name.isNotEmpty ? name : 'Película sin nombre';
  
  String? get posterUrl => streamIcon;
  
  String get displayYear => year ?? 'Año desconocido';
  
  String get displayDuration => duration ?? 'Duración desconocida';

  @override
  List<Object?> get props => [
        streamId,
        name,
        streamIcon,
        rating,
        year,
        genre,
        plot,
        cast,
        director,
        releasedate,
        duration,
        country,
        trailer,
        categoryId,
        containerExtension,
        added,
        rating5based,
        ratingImdb,
      ];
}

class SeriesModel extends Equatable {
  final String seriesId;
  final String name;
  final String? cover;
  final String? plot;
  final String? cast;
  final String? director;
  final String? genre;
  final String? releaseDate;
  final String? lastModified;
  final String? rating;
  final String? categoryId;
  final double? rating5based;
  final double? ratingImdb;

  const SeriesModel({
    required this.seriesId,
    required this.name,
    this.cover,
    this.plot,
    this.cast,
    this.director,
    this.genre,
    this.releaseDate,
    this.lastModified,
    this.rating,
    this.categoryId,
    this.rating5based,
    this.ratingImdb,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      seriesId: json['series_id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      cover: json['cover'] as String?,
      plot: json['plot'] as String?,
      cast: json['cast'] as String?,
      director: json['director'] as String?,
      genre: json['genre'] as String?,
      releaseDate: json['releaseDate'] as String?,
      lastModified: json['last_modified'] as String?,
      rating: json['rating'] as String?,
      categoryId: json['category_id']?.toString(),
      rating5based: (json['rating_5based'] as num?)?.toDouble(),
      ratingImdb: (json['rating_imdb'] as num?)?.toDouble(),
    );
  }

  String get displayName => name.isNotEmpty ? name : 'Serie sin nombre';
  
  String? get posterUrl => cover;

  @override
  List<Object?> get props => [
        seriesId,
        name,
        cover,
        plot,
        cast,
        director,
        genre,
        releaseDate,
        lastModified,
        rating,
        categoryId,
        rating5based,
        ratingImdb,
      ];
}

class LiveStreamModel extends Equatable {
  final String streamId;
  final String name;
  final String? streamIcon;
  final String? epgChannelId;
  final String? categoryId;
  final bool? tvArchive;
  final String? tvgName;
  final String? tvgLogo;
  final String? streamType;

  const LiveStreamModel({
    required this.streamId,
    required this.name,
    this.streamIcon,
    this.epgChannelId,
    this.categoryId,
    this.tvArchive,
    this.tvgName,
    this.tvgLogo,
    this.streamType,
  });

  factory LiveStreamModel.fromJson(Map<String, dynamic> json) {
    return LiveStreamModel(
      streamId: json['stream_id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      streamIcon: json['stream_icon'] as String?,
      epgChannelId: json['epg_channel_id']?.toString(),
      categoryId: json['category_id']?.toString(),
      tvArchive: json['tv_archive'] == 1,
      tvgName: json['tvg_name'] as String?,
      tvgLogo: json['tvg_logo'] as String?,
      streamType: json['stream_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stream_id': streamId,
      'name': name,
      'stream_icon': streamIcon,
      'epg_channel_id': epgChannelId,
      'category_id': categoryId,
      'tv_archive': tvArchive == true ? 1 : 0,
      'tvg_name': tvgName,
      'tvg_logo': tvgLogo,
      'stream_type': streamType,
    };
  }

  @override
  List<Object?> get props => [
        streamId,
        name,
        streamIcon,
        epgChannelId,
        categoryId,
        tvArchive,
        tvgName,
        tvgLogo,
        streamType,
      ];
}

class EpgEntryModel extends Equatable {
  final String id;
  final String title;
  final String start;
  final String end;
  final String? description;

  const EpgEntryModel({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    this.description,
  });

  factory EpgEntryModel.fromJson(Map<String, dynamic> json) {
    return EpgEntryModel(
      id: json['epg_id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      start: json['start'] as String? ?? '',
      end: json['end'] as String? ?? '',
      description: json['description'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, title, start, end, description];
}
