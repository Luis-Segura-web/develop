import 'package:equatable/equatable.dart';

/// Modelo básico de un stream (canal o VOD)
class StreamItem extends Equatable {
  final String streamId;
  final String name;
  final String? streamIcon;

  const StreamItem({
    required this.streamId,
    required this.name,
    this.streamIcon,
  });

  factory StreamItem.fromJson(Map<String, dynamic> json) {
    return StreamItem(
      streamId: json['stream_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      streamIcon: json['stream_icon']?.toString(),
    );
  }

  @override
  List<Object?> get props => [streamId, name, streamIcon];
}
