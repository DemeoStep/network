class JsonParseException implements Exception {
  final String message;
  final dynamic data;

  JsonParseException(this.message, this.data);

  @override
  String toString() => 'JsonParseException: $message\nData: $data';
}
