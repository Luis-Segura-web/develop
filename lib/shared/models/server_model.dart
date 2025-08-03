import 'package:equatable/equatable.dart';

class ServerModel extends Equatable {
  final String id;
  final String name;
  final String url;
  final String port;
  final String username;
  final String password;
  final bool isActive;
  final DateTime? lastLogin;
  final DateTime? expirationDate;
  final String? serverInfo;

  const ServerModel({
    required this.id,
    required this.name,
    required this.url,
    required this.port,
    required this.username,
    required this.password,
    this.isActive = false,
    this.lastLogin,
    this.expirationDate,
    this.serverInfo,
  });

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      port: json['port'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      isActive: json['isActive'] as bool? ?? false,
      lastLogin: json['lastLogin'] != null 
          ? DateTime.parse(json['lastLogin'] as String)
          : null,
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'] as String)
          : null,
      serverInfo: json['serverInfo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'port': port,
      'username': username,
      'password': password,
      'isActive': isActive,
      'lastLogin': lastLogin?.toIso8601String(),
      'expirationDate': expirationDate?.toIso8601String(),
      'serverInfo': serverInfo,
    };
  }

  ServerModel copyWith({
    String? id,
    String? name,
    String? url,
    String? port,
    String? username,
    String? password,
    bool? isActive,
    DateTime? lastLogin,
    DateTime? expirationDate,
    String? serverInfo,
  }) {
    return ServerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      port: port ?? this.port,
      username: username ?? this.username,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      lastLogin: lastLogin ?? this.lastLogin,
      expirationDate: expirationDate ?? this.expirationDate,
      serverInfo: serverInfo ?? this.serverInfo,
    );
  }

  String get fullUrl => url.contains('://') 
      ? '$url:$port' 
      : 'http://$url:$port';

  bool get isExpired => expirationDate != null && 
      expirationDate!.isBefore(DateTime.now());

  @override
  List<Object?> get props => [
        id,
        name,
        url,
        port,
        username,
        password,
        isActive,
        lastLogin,
        expirationDate,
        serverInfo,
      ];
}
