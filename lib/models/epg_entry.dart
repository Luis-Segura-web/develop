import 'package:isar/isar.dart';

part 'epg_entry.g.dart';

/// Entrada de Guía Electrónica de Programación
@collection
class EpgEntry {
  Id id = Isar.autoIncrement;

  @Index()
  final int channelId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime cacheExpiry;

  // Constructor sin const, id no es final
  EpgEntry({
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

  EpgEntry copyWith({
    int? channelId,
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? cacheExpiry,
  }) {
    return EpgEntry(
      channelId: channelId ?? this.channelId,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      cacheExpiry: cacheExpiry ?? this.cacheExpiry,
    );
  }


  /// Verificar si el programa está actualmente en vivo
  @ignore
  bool get isLive {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  /// Duración del programa en minutos
  @ignore
  int get durationInMinutes {
    return endTime.difference(startTime).inMinutes;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EpgEntry &&
        other.channelId == channelId &&
        other.startTime == startTime;
  }

  @override
  int get hashCode => Object.hash(channelId, startTime);

  // No incluir props en modelos Isar, solo si usas Equatable fuera de Isar
}