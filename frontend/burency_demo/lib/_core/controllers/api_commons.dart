const _apiRoute = 'ca';
const _contacts = 'Contact-';
const _history = 'History-';

class ApiRoutes {
  static const addContact = _apiRoute + _contacts + 'add';
  static const updateContact = _apiRoute + _contacts + 'update';
  static const deleteContact = _apiRoute + _contacts + 'delete';
  static const searchContact = _apiRoute + _contacts + 'search';
  static const searchNearbyContact = _apiRoute + _contacts + 'searchNearby';
  static const searchHistory = _apiRoute + _history + 'search';
}

class ErrorCode {
  static const String acctMismatch =
      'Username and password combination is invalid';
  static const String acctNotFound = 'Account not found';
  static const String usernameExists = 'Username already used';
  static const String pinMismatch =
      'The PIN codes that you entered does not match';
}

class HttpResponseCode {
  static const ok = 200;
  static const created = 201;
  static const accepted = 202;
  static const nonAuthoritativeInformation = 203;
  static const noContent = 204;
  static const resetContent = 205;
  static const partialContent = 206;
  static const badRequest = 400;
  static const unauthorized = 401;
  static const paymentRequired = 402;
  static const forbidden = 403;
  static const notFound = 404;
  static const methodNotAllowed = 405;
  static const notAcceptable = 406;
  static const proxyAuthenticationRequired = 407;
  static const requestTimeout = 408;
  static const conflict = 409;
  static const internalServerError = 500;
  static const notImplemented = 501;
  static const badGateway = 502;
  static const serviceUnavailable = 503;
  static const gatewayTimeout = 504;
  static const httpVersionNotSupported = 505;
  static const variantAlsoNegotiates = 506;
}

class ServerResultCode {
  static const String ok = 'OK';
}

class ServerErrorCode {
  static const String authLoginFailed = 'AUTH_LOGIN_FAILED';
  static const String authRegisterFailed = 'AUTH_REGISTER_FAILED';
  static const String authUnauthorized = 'AUTH_UNAUTHORIZED';
  static const String authAlreadyExists = 'AUTH_ALREADY_EXISTS';
  static const String authAccountActivationFailed =
      'AUTH_ACCOUNT_ACTIVATION_FAILED';
  static const String pinSetFailed = 'PIN_SET_FAILED';
  static const String pinUnauthorized = 'PIN_UNAUTHORIZED';
  static const String dataNotFound = 'DATA_NOT_FOUND';
  static const String serverUnavailable = 'SERVER_UNAVAILABLE';
  static const String serverError = 'SERVER_ERROR';
}

class ErrorModel {
  String code;
  String message;

  ErrorModel({
    this.code = '',
    this.message = '',
  });

  factory ErrorModel.from(dynamic jsonData) {
    if (jsonData == null) {
      return ErrorModel();
    }

    return ErrorModel(
      code: jsonData['code'] ?? '',
      message: jsonData['message'] ?? '',
    );
  }

  dynamic toJson() => {
        'code': code,
        'message': message,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
