class GenericObjectResponse<T> {
  int? status;
  String? message;
  T? data;

  GenericObjectResponse({this.status, this.message, this.data});

  factory GenericObjectResponse.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonData) {
    return GenericObjectResponse<T>(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? fromJsonData(json['data']) : null,
    );
  }
}