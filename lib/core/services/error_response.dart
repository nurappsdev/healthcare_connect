class ApiResponse {
  final int? statusCode;
  final String? statusText;
  final dynamic body;
  final String? bodyString;
  final Map<String, String>? headers;

  const ApiResponse({
    this.statusCode,
    this.statusText,
    this.body,
    this.bodyString,
    this.headers,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    statusText: json["statusText"],
    statusCode: json["statusCode"],
    bodyString: json["bodyString"],
  );

}