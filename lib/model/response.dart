class APIResponse {
  final String status;
  final String message;
  final String processTimeInSecond;

  APIResponse({this.status, this.message, this.processTimeInSecond});

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
        status: json.containsKey('status') ? json['status'].toString() : null,
        message: json.containsKey('message') ? json['message'] : null,
        processTimeInSecond: 0.toString());
  }

  APIResponse copyWith(
      {String status, String message, int processTimeInSecond}) {
    return APIResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        processTimeInSecond: processTimeInSecond != null
            ? '$processTimeInSecond s'
            : this.processTimeInSecond);
  }
}
