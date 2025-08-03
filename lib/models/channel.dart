import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'channel.g.dart';

/// Canal de televisión en vivo
@collection
class Channel extends Equatable {
  Id id = Isar.autoIncrement;
  
  @Index()
  final int streamId;
  final String name;
  final String streamIcon;
  final int categoryId;
  final String streamType;
  final bool hasArchive;
  final DateTime? created;
  final DateTime? addedOn;
  
  // Cache TTL
  final DateTime cacheExpiry;

  const Channel({
    required this.streamId,
    required this.name,
    required this.streamIcon,
    required this.categoryId,
    required this.streamType,
    this.hasArchive = false,
    this.created,
    this.addedOn,
    required this.cacheExpiry,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      streamId: int.parse(json['stream_id'].toString()),
      name: json['name'] as String,
      streamIcon: json['stream_icon'] as String? ?? '',
      categoryId: int.parse(json['category_id'].toString()),
      streamType: json['stream_type'] as String? ?? 'live',
      hasArchive: json['has_archive'] == 1 || json['has_archive'] == true,
      created: json['created'] != null 
          ? DateTime.parse(json['created'].toString())
          : null,
      addedOn: json['added'] != null 
          ? DateTime.parse(json['added'].toString())
          : null,
      cacheExpiry: DateTime.now().add(const Duration(hours: 1)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stream_id': streamId,
      'name': name,
      'stream_icon': streamIcon,
      'category_id': categoryId,
      'stream_type': streamType,
      'has_archive': hasArchive ? 1 : 0,
      'created': created?.toIso8601String(),
      'added': addedOn?.toIso8601String(),
    };
  }

  @override
  @ignore
  List<Object?> get props => [
        streamId,
        name,
        streamIcon,
        categoryId,
        streamType,
        hasArchive,
        created,
        addedOn,
      ];
}