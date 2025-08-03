import 'package:equatable/equatable.dart';

/// Item genérico de stream para el reproductor
abstract class StreamItem extends Equatable {
  final int streamId;
  final String name;
  final String streamIcon;
  final int categoryId;

  const StreamItem({
    required this.streamId,
    required this.name,
    required this.streamIcon,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [streamId, name, streamIcon, categoryId];
}

/// Item de stream en vivo
class LiveStreamItem extends StreamItem {
  final String streamType;
  final bool hasArchive;

  const LiveStreamItem({
    required super.streamId,
    required super.name,
    required super.streamIcon,
    required super.categoryId,
    required this.streamType,
    this.hasArchive = false,
  });

  @override
  List<Object?> get props => [...super.props, streamType, hasArchive];
}

/// Item de VOD stream
class VodStreamItem extends StreamItem {
  final String containerExtension;
  final String plot;

  const VodStreamItem({
    required super.streamId,
    required super.name,
    required super.streamIcon,
    required super.categoryId,
    required this.containerExtension,
    required this.plot,
  });

  @override
  List<Object?> get props => [...super.props, containerExtension, plot];
}

/// Item de Serie stream
class SeriesStreamItem extends StreamItem {
  final int seriesId;
  final String plot;

  const SeriesStreamItem({
    required super.streamId,
    required super.name,
    required super.streamIcon,
    required super.categoryId,
    required this.seriesId,
    required this.plot,
  });

  @override
  List<Object?> get props => [...super.props, seriesId, plot];
}