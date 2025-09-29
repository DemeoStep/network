class ApiResponse {
  final Object? body;
  final int statusCode;
  final Map<String, String> headers;
  final bool isRedirect;

  const ApiResponse({
    this.body,
    required this.statusCode,
    this.headers = const {},
    this.isRedirect = false,
  });
}
