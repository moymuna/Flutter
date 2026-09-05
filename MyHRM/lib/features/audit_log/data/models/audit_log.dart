class AuditLogResponse {
  final int id;
  final String? entityType;
  final int? entityId;
  final String? action;
  final String? performedBy;
  final String? details;
  final String? timestamp;

  AuditLogResponse({
    required this.id,
    this.entityType,
    this.entityId,
    this.action,
    this.performedBy,
    this.details,
    this.timestamp,
  });

  factory AuditLogResponse.fromJson(Map<String, dynamic> json) {
    return AuditLogResponse(
      id: json['id'] as int,
      entityType: json['entityType'] as String?,
      entityId: json['entityId'] as int?,
      action: json['action'] as String?,
      performedBy: json['performedBy'] as String?,
      details: json['details'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }

  @override
  String toString() => 'AuditLog #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AuditLogResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
