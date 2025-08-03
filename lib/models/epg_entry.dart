import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'epg_entry.g.dart';

/// Entrada de Guía Electrónica de Programación
@collection
class EpgEntry extends Equatable {
  Id id = Isar.autoIncrement;
  
  @Index()
  final int channelId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  
  // Cache TTL
  final DateTime cacheExpiry;

  const EpgEntry({
    required this.channelId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.cacheExpiry,
  });

  factory EpgEntry.fromJson(Map<String, dynamic> json) {
    return EpgEntry(
      channelId: int.parse(json['channel_id'].toString()),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      startTime: DateTime.parse(json['start'].toString()),
      endTime: DateTime.parse(json['stop'].toString()),
      cacheExpiry: DateTime.now().add(const Duration(hours: 2)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channel_id': channelId,
      'title': title,
      'description': description,
      'start': startTime.toIso8601String(),
      'stop': endTime.toIso8601String(),
    };
  }

  /// Verificar si el programa está actualmente en vivo
  bool get isLive {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  /// Duración del programa en minutos
  int get durationInMinutes {
    return endTime.difference(startTime).inMinutes;
  }

  @override
  List<Object?> get props => [
        channelId,
        title,
        description,
        startTime,
        endTime,
      ];
}