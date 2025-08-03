import 'package:equatable/equatable.dart';

class ChannelModel extends Equatable {
  final String streamId;
  final String name;
  final String? icon;
  final String? epgChannelId;
  final String categoryId;
  final int? tvgId;
  final String? tvgName;
  final String? tvgLogo;
  final String? tvgShift;
  final String? groupTitle;
  final String? streamType;
  final bool? added;
  final bool? isAdult;
  final String? containerExtension;

  const ChannelModel({
    required this.streamId,
    required this.name,
    this.icon,
    this.epgChannelId,
    required this.categoryId,
    this.tvgId,
    this.tvgName,
    this.tvgLogo,
    this.tvgShift,
    this.groupTitle,
    this.streamType,
    this.added,
    this.isAdult,
    this.containerExtension,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      streamId: json['stream_id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      icon: json['stream_icon'] as String?,
      epgChannelId: json['epg_channel_id'] as String?,
      categoryId: json['category_id']?.toString() ?? '',
      tvgId: json['tv_archive'] as int?,
      tvgName: json['tvg_name'] as String?,
      tvgLogo: json['tvg_logo'] as String?,
      tvgShift: json['tvg_shift'] as String?,
      groupTitle: json['group_title'] as String?,
      streamType: json['stream_type'] as String?,
      added: json['added'] as bool?,
      isAdult: json['is_adult'] as bool? ?? false,
      containerExtension: json['container_extension'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stream_id': streamId,
      'name': name,
      'stream_icon': icon,
      'epg_channel_id': epgChannelId,
      'category_id': categoryId,
      'tv_archive': tvgId,
      'tvg_name': tvgName,
      'tvg_logo': tvgLogo,
      'tvg_shift': tvgShift,
      'group_title': groupTitle,
      'stream_type': streamType,
      'added': added,
      'is_adult': isAdult,
      'container_extension': containerExtension,
    };
  }

  ChannelModel copyWith({
    String? streamId,
    String? name,
    String? icon,
    String? epgChannelId,
    String? categoryId,
    int? tvgId,
    String? tvgName,
    String? tvgLogo,
    String? tvgShift,
    String? groupTitle,
    String? streamType,
    bool? added,
    bool? isAdult,
    String? containerExtension,
  }) {
    return ChannelModel(
      streamId: streamId ?? this.streamId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      epgChannelId: epgChannelId ?? this.epgChannelId,
      categoryId: categoryId ?? this.categoryId,
      tvgId: tvgId ?? this.tvgId,
      tvgName: tvgName ?? this.tvgName,
      tvgLogo: tvgLogo ?? this.tvgLogo,
      tvgShift: tvgShift ?? this.tvgShift,
      groupTitle: groupTitle ?? this.groupTitle,
      streamType: streamType ?? this.streamType,
      added: added ?? this.added,
      isAdult: isAdult ?? this.isAdult,
      containerExtension: containerExtension ?? this.containerExtension,
    );
  }

  String get displayName => name.isNotEmpty ? name : 'Canal sin nombre';
  
  String? get logoUrl => icon?.isNotEmpty == true ? icon : tvgLogo;
  
  bool get hasArchive => tvgId != null && tvgId! > 0;

  @override
  List<Object?> get props => [
        streamId,
        name,
        icon,
        epgChannelId,
        categoryId,
        tvgId,
        tvgName,
        tvgLogo,
        tvgShift,
        groupTitle,
        streamType,
        added,
        isAdult,
        containerExtension,
      ];
}
