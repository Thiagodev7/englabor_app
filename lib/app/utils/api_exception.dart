class ApiException implements Exception {
  final String message;
  final List<FieldError>? errors;

  ApiException(this.message, [this.errors]);

  @override
  String toString() => message; 
}

class FieldError {
  final String field;
  final String message;

  FieldError(this.field, this.message);

  factory FieldError.fromJson(Map<String, dynamic> json) =>
      FieldError(json['field'], json['message']);
}