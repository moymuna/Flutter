class DocumentResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final String? title;
  final String? documentType;
  final String? filePath;
  final String? uploadedAt;

  DocumentResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.title,
    this.documentType,
    this.filePath,
    this.uploadedAt,
  });

  factory DocumentResponse.fromJson(Map<String, dynamic> json) {
    return DocumentResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      title: json['title'] as String?,
      documentType: json['documentType'] as String?,
      filePath: json['filePath'] as String?,
      uploadedAt: json['uploadedAt'] as String?,
    );
  }

  @override
  String toString() => title ?? 'Document #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DocumentResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
