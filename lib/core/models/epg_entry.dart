import 'package:equatable/equatable.dart';

/// Modelo de entrada EPG (guía electrónica de programas)
class EpgEntry extends Equatable {
  final String channelId;
  final DateTime start;
  final DateTime end;
  final String title;
  final String? description;

  const EpgEntry({
    required this.channelId,
    required this.start,
    required this.end,
    required this.title,
    this.description,
  });

  factory EpgEntry.fromJson(Map<String, dynamic> json) {
    return EpgEntry(
      channelId: json['channel_id']?.toString() ?? '',
      start: DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(json['start_time']?.toString() ?? '') ?? 0),
      end: DateTime.fromMillisecondsSinceEpoch(
          int.tryParse(json['end_time']?.toString() ?? '') ?? 0),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
    );
  }

  @override
  List<Object?> get props => [channelId, start, end, title, description];
}
