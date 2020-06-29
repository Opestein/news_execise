class ErrorResponse {
  final String message;

  ErrorResponse({
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        message: json["message"] == null ? '' : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
