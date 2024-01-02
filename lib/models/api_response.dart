class ResponseStatus {
  String message;
  bool success;
  ResponseStatus({
    required this.message,
    required this.success,
  });

  ResponseStatus copyWith({
    String? message,
    bool? success,
  }) {
    return ResponseStatus(
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'success': success,
    };
  }

  factory ResponseStatus.fromMap(Map<String, dynamic> map) {
    return ResponseStatus(
      message: map['message'] ?? "",
      success: map['success'] ?? false,
    );
  }

  @override
  String toString() => 'ResponseStatus(message: $message, success: $success)';
}
