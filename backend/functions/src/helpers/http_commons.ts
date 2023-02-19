/* eslint-disable  @typescript-eslint/no-explicit-any */
import * as functions from 'firebase-functions';

import { ErrorCode, FirebaseErrorCode, HttpResponseCode } from '../constants/result_code';
import { ErrorData, FirebaseErrorData, HttpResult } from '../models/http_result';

export function httpOk(payload: any): HttpResult {
  return new HttpResult(
    HttpResponseCode.ok,
    payload,
  );
}

export function httpError(error: any) {
  if (error instanceof functions.https.HttpsError) {
    const httpsError = error as functions.https.HttpsError;
    return httpErrorFromFirebaseErrorCode(httpsError.code, httpsError.message);
  } else if (error.errorInfo) {
    const firebaseError = error.errorInfo;
    return httpErrorFromFirebaseErrorCode(firebaseError.code, firebaseError.message);
  } else if (error.name && error.message && error.status) {
    return httpErrorFromFirebaseErrorCode(FirebaseErrorCode.AUTH_INVALID_ARGUMENT, error.message);
  } else {
    return httpErrorFromErrorCode(error, new ErrorData(error, ''));
  }
}

export function firebaseError(code: FirebaseErrorCode, message: string): FirebaseErrorData {
  return new FirebaseErrorData(code, message);
}

function httpErrorFromErrorCode(errorCode: ErrorCode, data: ErrorData): HttpResult {
  let status = HttpResponseCode.badRequest;

  switch (errorCode) {
    case ErrorCode.AUTH_UNAUTHORIZED:
      status = HttpResponseCode.unauthorized;
      break;
    case ErrorCode.INVALID_PARAMETER:
       status = HttpResponseCode.methodNotAllowed;
       break;
    case ErrorCode.DATA_NOT_FOUND:
      status = HttpResponseCode.noContent;
      break;
  }

  return new HttpResult(
    status,
    data,
  );
}

function httpErrorFromFirebaseErrorCode(code: string, message: string): HttpResult {
  let status = HttpResponseCode.badRequest;
  const data = new ErrorData(code, message);

  switch (code) {
    case FirebaseErrorCode.AUTH_USER_NOT_FOUND:
    case FirebaseErrorCode.AUTH_UNAUTHORIZED_CONTINUE_URI:
    case FirebaseErrorCode.AUTH_INVALID_API_KEY:
    case FirebaseErrorCode.AUTH_INVALID_USER_TOKEN:
    case FirebaseErrorCode.AUTH_REQUIRES_RECENT_LOGIN:
    case FirebaseErrorCode.AUTH_USER_DISABLED:
    case FirebaseErrorCode.AUTH_USER_TOKEN_EXPIRED:
    case FirebaseErrorCode.AUTH_ID_TOKEN_EXPIRED:
    case FirebaseErrorCode.AUTH_ID_TOKEN_REVOKED:
    case FirebaseErrorCode.AUTH_INVALID_OAUTH_RESPONSE_TYPE:
    case FirebaseErrorCode.AUTH_INVALID_SESSION_COOKIE_DURATION:
      status = HttpResponseCode.unauthorized;
      break;
    case FirebaseErrorCode.AUTH_ARGUMENT_ERROR:
    case FirebaseErrorCode.AUTH_INVALID_ARGUMENT:
    case FirebaseErrorCode.AUTH_EMAIL_ALREADY_EXISTS:
    case FirebaseErrorCode.AUTH_INVALID_CONTINUE_URI:
    case FirebaseErrorCode.AUTH_INVALID_CREATION_TIME:
    case FirebaseErrorCode.AUTH_INVALID_DISABLED_FIELD:
    case FirebaseErrorCode.AUTH_INVALID_DISPLAY_NAME:
    case FirebaseErrorCode.AUTH_INVALID_EMAIL:
    case FirebaseErrorCode.AUTH_INVALID_EMAIL_VERIFIED:
    case FirebaseErrorCode.AUTH_INVALID_HASH_ALGORITHM:
    case FirebaseErrorCode.AUTH_INVALID_HASH_BLOCK_SIZE:
    case FirebaseErrorCode.AUTH_INVALID_HASH_DERIVED_KEY_LENGTH:
    case FirebaseErrorCode.AUTH_INVALID_HASH_KEY:
    case FirebaseErrorCode.AUTH_INVALID_HASH_MEMORY_COST:
    case FirebaseErrorCode.AUTH_INVALID_HASH_PARALLELIZATION:
    case FirebaseErrorCode.AUTH_INVALID_HASH_ROUNDS:
    case FirebaseErrorCode.AUTH_INVALID_HASH_SALT_SEPARATOR:
    case FirebaseErrorCode.AUTH_INVALID_ID_TOKEN:
    case FirebaseErrorCode.AUTH_INVALID_LAST_SIGN_IN_TIME:
    case FirebaseErrorCode.AUTH_INVALID_PAGE_TOKEN:
    case FirebaseErrorCode.AUTH_INVALID_PASSWORD:
    case FirebaseErrorCode.AUTH_INVALID_PASSWORD_HASH:
    case FirebaseErrorCode.AUTH_INVALID_PASSWORD_SALT:
    case FirebaseErrorCode.AUTH_INVALID_PHONE_NUMBER:
    case FirebaseErrorCode.AUTH_INVALID_PHOTO_URL:
    case FirebaseErrorCode.AUTH_INVALID_PROVIDER_DATA:
    case FirebaseErrorCode.AUTH_INVALID_PROVIDER_ID:
    case FirebaseErrorCode.AUTH_INVALID_UID:
    case FirebaseErrorCode.AUTH_UID_ALREADY_EXIST:
    case FirebaseErrorCode.AUTH_PHONE_NUMBER_ALREADY_EXIST:
      status = HttpResponseCode.notAcceptable;
      break;
    case FirebaseErrorCode.AUTH_WEB_STORAGE_UNSUPPORTED:
      status = HttpResponseCode.notImplemented;
      break;
    case FirebaseErrorCode.AUTH_NETWORK_REQUEST_FAILED:
    case FirebaseErrorCode.AUTH_TOO_MANY_REQUESTS:
    case FirebaseErrorCode.AUTH_MAX_USER_COUNT_EXCEEDED:
      status = HttpResponseCode.serviceUnavailable;
      break;
    case FirebaseErrorCode.AUTH_UNAUTHORIZED_DOMAIN:
    case FirebaseErrorCode.AUTH_OPERATION_NOT_ALLOWED:
      status = HttpResponseCode.forbidden;
      break;
    case FirebaseErrorCode.AUTH_INTERNAL_ERROR:
    case FirebaseErrorCode.AUTH_APP_DELETED:
    case FirebaseErrorCode.AUTH_APP_NOT_AUTHORIZED:
    case FirebaseErrorCode.AUTH_INVALID_TENANT_ID:
    case FirebaseErrorCode.AUTH_INSUFFICIENT_PERMISSION:
    case FirebaseErrorCode.AUTH_CLAIMS_TOO_LARGE:
    case FirebaseErrorCode.AUTH_INVALID_CLAIMS:
    case FirebaseErrorCode.AUTH_RESERVED_CLAIMS:
    case FirebaseErrorCode.AUTH_INVALID_CREDENTIAL:
    case FirebaseErrorCode.AUTH_INVALID_DYNAMIC_LINK_DOMAIN:
    case FirebaseErrorCode.AUTH_INVALID_USER_IMPORT:
    case FirebaseErrorCode.AUTH_MISSING_ANDROID_PKG_NAME:
    case FirebaseErrorCode.AUTH_MISSING_CONTINUE_URI:
    case FirebaseErrorCode.AUTH_MISSING_HASH_ALGORITHM:
    case FirebaseErrorCode.AUTH_MISSING_IOS_BUNDLE_ID:
    case FirebaseErrorCode.AUTH_MISSING_UID:
    case FirebaseErrorCode.AUTH_MISSING_OAUTH_CLIENT_SECRET:
    case FirebaseErrorCode.AUTH_PROJECT_NOT_FOUND:
    case FirebaseErrorCode.AUTH_SESSION_COOKIE_EXPIRED:
    case FirebaseErrorCode.AUTH_SESSION_COOKIE_REVOKED:
      status = HttpResponseCode.internalServerError;
      break;
  }

  return new HttpResult(
    status,
    data,
  );
}
