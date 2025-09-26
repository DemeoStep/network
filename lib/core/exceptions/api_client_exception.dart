class ApiClientException implements Exception {
  final String message;
  final int statusCode;
  final ApiClientExceptionType type;
  final Object? response;

  ApiClientException({required this.message, required this.type, this.response})
    : statusCode = type.code;

  @override
  String toString() {
    return 'ApiClientException($statusCode): ${type.name}';
  }
}

enum ApiClientExceptionType {
  unknown(-1),
  connectionTimeout(-2),
  sendTimeout(-3),
  receiveTimeout(-4),
  cancel(-5),
  connectionError(-6),
  badCertificate(-7),
  requestCancelled(-8),
  noInternetConnection(-9),

  continue_(100),
  switchingProtocols(101),
  processing(102),
  ok(200),
  created(201),
  accepted(202),
  nonAuthoritativeInformation(203),
  noContent(204),
  resetContent(205),
  partialContent(206),
  multiStatus(207),
  alreadyReported(208),
  imUsed(226),
  multipleChoices(300),
  movedPermanently(301),
  found(302),
  movedTemporarily(302), // Common alias for found.
  seeOther(303),
  notModified(304),
  useProxy(305),
  temporaryRedirect(307),
  permanentRedirect(308),
  badRequest(400),
  unauthorized(401),
  paymentRequired(402),
  forbidden(403),
  notFound(404),
  methodNotAllowed(405),
  notAcceptable(406),
  proxyAuthenticationRequired(407),
  requestTimeout(408),
  conflict(409),
  gone(410),
  lengthRequired(411),
  preconditionFailed(412),
  requestEntityTooLarge(413),
  requestUriTooLong(414),
  unsupportedMediaType(415),
  requestedRangeNotSatisfiable(416),
  expectationFailed(417),
  misdirectedRequest(421),
  unprocessableEntity(422),
  locked(423),
  failedDependency(424),
  upgradeRequired(426),
  preconditionRequired(428),
  tooManyRequests(429),
  requestHeaderFieldsTooLarge(431),
  connectionClosedWithoutResponse(444),
  unavailableForLegalReasons(451),
  clientClosedRequest(499),
  internalServerError(500),
  notImplemented(501),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504),
  httpVersionNotSupported(505),
  variantAlsoNegotiates(506),
  insufficientStorage(507),
  loopDetected(508),
  notExtended(510),
  networkAuthenticationRequired(511),
  networkConnectTimeoutError(599);

  final int code;

  const ApiClientExceptionType(this.code);

  static ApiClientExceptionType fromCode(int code) {
    return ApiClientExceptionType.values.firstWhere(
      (e) => e.code == code,
      orElse: () => ApiClientExceptionType.unknown,
    );
  }
}

extension ApiClientExceptionTypeExtension on ApiClientExceptionType {
  String get name {
    switch (this) {
      case ApiClientExceptionType.unknown:
        return 'Unknown error';
      case ApiClientExceptionType.connectionTimeout:
        return 'Connection timeout';
      case ApiClientExceptionType.sendTimeout:
        return 'Send timeout';
      case ApiClientExceptionType.receiveTimeout:
        return 'Receive timeout';
      case ApiClientExceptionType.cancel:
        return 'Request cancelled';
      case ApiClientExceptionType.connectionError:
        return 'Connection error';
      case ApiClientExceptionType.badCertificate:
        return 'Bad certificate';
      case ApiClientExceptionType.requestCancelled:
        return 'Request cancelled by user';
      case ApiClientExceptionType.noInternetConnection:
        return 'No internet connection';
      case ApiClientExceptionType.continue_:
        return 'Continue';
      case ApiClientExceptionType.switchingProtocols:
        return 'Switching Protocols';
      case ApiClientExceptionType.processing:
        return 'Processing';
      case ApiClientExceptionType.ok:
        return 'OK';
      case ApiClientExceptionType.created:
        return 'Created';
      case ApiClientExceptionType.accepted:
        return 'Accepted';
      case ApiClientExceptionType.nonAuthoritativeInformation:
        return 'Non-Authoritative Information';
      case ApiClientExceptionType.noContent:
        return 'No Content';
      case ApiClientExceptionType.resetContent:
        return 'Reset Content';
      case ApiClientExceptionType.partialContent:
        return 'Partial Content';
      case ApiClientExceptionType.multiStatus:
        return 'Multi-Status';
      case ApiClientExceptionType.alreadyReported:
        return 'Already Reported';
      case ApiClientExceptionType.imUsed:
        return 'IM Used';
      case ApiClientExceptionType.multipleChoices:
        return 'Multiple Choices';
      case ApiClientExceptionType.movedPermanently:
        return 'Moved Permanently';
      case ApiClientExceptionType.found:
        return 'Found';
      case ApiClientExceptionType.movedTemporarily:
        return 'Moved Temporarily';
      case ApiClientExceptionType.seeOther:
        return 'See Other';
      case ApiClientExceptionType.notModified:
        return 'Not Modified';
      case ApiClientExceptionType.useProxy:
        return 'Use Proxy';
      case ApiClientExceptionType.temporaryRedirect:
        return 'Temporary Redirect';
      case ApiClientExceptionType.permanentRedirect:
        return 'Permanent Redirect';
      case ApiClientExceptionType.badRequest:
        return 'Bad Request';
      case ApiClientExceptionType.unauthorized:
        return 'Unauthorized';
      case ApiClientExceptionType.paymentRequired:
        return 'Payment Required';
      case ApiClientExceptionType.forbidden:
        return 'Forbidden';
      case ApiClientExceptionType.notFound:
        return 'Not Found';
      case ApiClientExceptionType.methodNotAllowed:
        return 'Method Not Allowed';
      case ApiClientExceptionType.notAcceptable:
        return 'Not Acceptable';
      case ApiClientExceptionType.proxyAuthenticationRequired:
        return 'Proxy Authentication Required';
      case ApiClientExceptionType.requestTimeout:
        return 'Request Timeout';
      case ApiClientExceptionType.conflict:
        return 'Conflict';
      case ApiClientExceptionType.gone:
        return 'Gone';
      case ApiClientExceptionType.lengthRequired:
        return 'Length Required';
      case ApiClientExceptionType.preconditionFailed:
        return 'Precondition Failed';
      case ApiClientExceptionType.requestEntityTooLarge:
        return 'Request Entity Too Large';
      case ApiClientExceptionType.requestUriTooLong:
        return 'Request-URI Too Long';
      case ApiClientExceptionType.unsupportedMediaType:
        return 'Unsupported Media Type';
      case ApiClientExceptionType.requestedRangeNotSatisfiable:
        return 'Requested Range Not Satisfiable';
      case ApiClientExceptionType.expectationFailed:
        return 'Expectation Failed';
      case ApiClientExceptionType.misdirectedRequest:
        return 'Misdirected Request';
      case ApiClientExceptionType.unprocessableEntity:
        return 'Unprocessable Entity';
      case ApiClientExceptionType.locked:
        return 'Locked';
      case ApiClientExceptionType.failedDependency:
        return 'Failed Dependency';
      case ApiClientExceptionType.upgradeRequired:
        return 'Upgrade Required';
      case ApiClientExceptionType.preconditionRequired:
        return 'Precondition Required';
      case ApiClientExceptionType.tooManyRequests:
        return 'Too Many Requests';
      case ApiClientExceptionType.requestHeaderFieldsTooLarge:
        return 'Request Header Fields Too Large';
      case ApiClientExceptionType.connectionClosedWithoutResponse:
        return 'Connection Closed Without Response';
      case ApiClientExceptionType.unavailableForLegalReasons:
        return 'Unavailable For Legal Reasons';
      case ApiClientExceptionType.clientClosedRequest:
        return 'Client Closed Request';
      case ApiClientExceptionType.internalServerError:
        return 'Internal Server Error';
      case ApiClientExceptionType.notImplemented:
        return 'Not Implemented';
      case ApiClientExceptionType.badGateway:
        return 'Bad Gateway';
      case ApiClientExceptionType.serviceUnavailable:
        return 'Service Unavailable';
      case ApiClientExceptionType.gatewayTimeout:
        return 'Gateway Timeout';
      case ApiClientExceptionType.httpVersionNotSupported:
        return 'HTTP Version Not Supported';
      case ApiClientExceptionType.variantAlsoNegotiates:
        return 'Variant Also Negotiates';
      case ApiClientExceptionType.insufficientStorage:
        return 'Insufficient Storage';
      case ApiClientExceptionType.loopDetected:
        return 'Loop Detected';
      case ApiClientExceptionType.notExtended:
        return 'Not Extended';
      case ApiClientExceptionType.networkAuthenticationRequired:
        return 'Network Authentication Required';
      case ApiClientExceptionType.networkConnectTimeoutError:
        return 'Network Connect Timeout Error';
    }
  }
}
