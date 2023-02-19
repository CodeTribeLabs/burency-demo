// Standard HTTP Response Codes
export class HttpResponseCode {
    public static readonly ok = 200;
    public static readonly created = 201;
    public static readonly accepted = 202;
    public static readonly nonAuthoritativeInformation = 203;
    public static readonly noContent = 204;
    public static readonly resetContent = 205;
    public static readonly partialContent = 206;
    public static readonly badRequest = 400;
    public static readonly unauthorized = 401;
    public static readonly paymentRequired = 402;
    public static readonly forbidden = 403;
    public static readonly notFound = 404;
    public static readonly methodNotAllowed = 405;
    public static readonly notAcceptable = 406;
    public static readonly proxyAuthenticationRequired = 407;
    public static readonly requestTimeout = 408;
    public static readonly conflict = 409;
    public static readonly internalServerError = 500;
    public static readonly notImplemented = 501;
    public static readonly badGateway = 502;
    public static readonly serviceUnavailable = 503;
    public static readonly gatewayTimeout = 504;
    public static readonly httpVersionNotSupported = 505;
    public static readonly variantAlsoNegotiates = 506;
}

export enum ErrorCode {
    AUTH_UNAUTHORIZED = 'AUTH_UNAUTHORIZED',
    DATA_NOT_FOUND = 'DATA_NOT_FOUND',
    INVALID_PARAMETER = 'INVALID_PARAMETER',
    SERVER_ERROR = 'SERVER_ERROR',
}

// Firebase Error Codes
// https://firebase.google.com/docs/auth/admin/errors
// https://firebase.google.com/docs/reference/js/v8/firebase.auth.Error
export enum FirebaseErrorCode {
    // Instance of FirebaseApp has been deleted.
    AUTH_APP_DELETED = 'auth/app-deleted',
    // The app identified by the domain where it's hosted, is not authorized to use Firebase Authentication with the provided API key.
    AUTH_APP_NOT_AUTHORIZED = 'auth/app-not-authorized',
    // If a method is called with incorrect arguments.
    AUTH_ARGUMENT_ERROR = 'auth/argument-error',
    // If the provided API key is invalid. Please check that you have copied it correctly from the Firebase Console.
    AUTH_INVALID_API_KEY = 'auth/invalid-api-key',
    // If the user's credential is no longer valid. The user must sign in again.
    AUTH_INVALID_USER_TOKEN = 'auth/invalid-user-token',
    // If the tenant ID provided is invalid.
    AUTH_INVALID_TENANT_ID = 'auth/invalid-tenant-id',
    // If a network error (such as timeout, interrupted connection or unreachable host) has occurred.
    AUTH_NETWORK_REQUEST_FAILED = 'auth/network-request-failed',
    // If the user's last sign-in time does not meet the security threshold.
    AUTH_REQUIRES_RECENT_LOGIN = 'auth/requires-recent-login',
    // If requests are blocked from a device due to unusual activity. Trying again after some delay would unblock.
    AUTH_TOO_MANY_REQUESTS = 'auth/too-many-requests',
    // If the app domain is not authorized for OAuth operations for your Firebase project. Edit the list of authorized domains from the Firebase console.
    AUTH_UNAUTHORIZED_DOMAIN = 'auth/unauthorized-domain',
    // If the user account has been disabled by an administrator. Accounts can be enabled or disabled in the Firebase Console.
    AUTH_USER_DISABLED = 'auth/user-disabled',
    // If the user's credential has expired. This could also be thrown if a user has been deleted.
    AUTH_USER_TOKEN_EXPIRED = 'auth/user-token-expired',
    // If the browser does not support web storage or if the user disables them.
    AUTH_WEB_STORAGE_UNSUPPORTED = 'auth/web-storage-unsupported',
    // The claims payload provided to setCustomUserClaims() exceeds the maximum allowed size of 1000 bytes.
    AUTH_CLAIMS_TOO_LARGE = 'auth/claims-too-large',
    // The provided email is already in use by an existing user. Each user must have a unique email.
    AUTH_EMAIL_ALREADY_EXISTS = 'auth/email-already-exists',
    // The provided Firebase ID token is expired.
    AUTH_ID_TOKEN_EXPIRED = 'auth/id-token-expired',
    // The Firebase ID token has been revoked.
    AUTH_ID_TOKEN_REVOKED = 'auth/id-token-revoked',
    // The credential used to initialize the Admin SDK has insufficient permission to access the requested Authentication resource.
    AUTH_INSUFFICIENT_PERMISSION = 'auth/insufficient-permission',
    // The Authentication server encountered an unexpected error while trying to process the request.
    AUTH_INTERNAL_ERROR = 'auth/internal-error',
    // An invalid argument was provided to an Authentication method.
    AUTH_INVALID_ARGUMENT = 'auth/invalid-argument',
    // The custom claim attributes provided to setCustomUserClaims() are invalid.
    AUTH_INVALID_CLAIMS = 'auth/invalid-claims',
    // The continue URL must be a valid URL string.
    AUTH_INVALID_CONTINUE_URI = 'auth/invalid-continue-uri',
    // The creation time must be a valid UTC date string.
    AUTH_INVALID_CREATION_TIME = 'auth/invalid-creation-time',
    // The credential used to authenticate the Admin SDKs cannot be used to perform the desired action.
    AUTH_INVALID_CREDENTIAL = 'auth/invalid-credential',
    // The provided value for the disabled user property is invalid. It must be a boolean.
    AUTH_INVALID_DISABLED_FIELD = 'auth/invalid-disabled-field',
    // The provided value for the displayName user property is invalid. It must be a non-empty string.
    AUTH_INVALID_DISPLAY_NAME = 'auth/invalid-display-name',
    // The provided dynamic link domain is not configured or authorized for the current project.
    AUTH_INVALID_DYNAMIC_LINK_DOMAIN = 'auth/invalid-dynamic-link-domain',
    // The provided value for the email user property is invalid. It must be a string email address.
    AUTH_INVALID_EMAIL = 'auth/invalid-email',
    // The provided value for the emailVerified user property is invalid. It must be a boolean.
    AUTH_INVALID_EMAIL_VERIFIED = 'auth/invalid-email-verified',
    // The hash algorithm must match one of the strings in the list of supported algorithms.
    AUTH_INVALID_HASH_ALGORITHM = 'auth/invalid-hash-algorithm',
    // The hash block size must be a valid number.
    AUTH_INVALID_HASH_BLOCK_SIZE = 'auth/invalid-hash-block-size',
    // The hash derived key length must be a valid number.
    AUTH_INVALID_HASH_DERIVED_KEY_LENGTH = 'auth/invalid-hash-derived-key-length',
    // The hash key must a valid byte buffer.
    AUTH_INVALID_HASH_KEY = 'auth/invalid-hash-key',
    // The hash memory cost must be a valid number.
    AUTH_INVALID_HASH_MEMORY_COST = 'auth/invalid-hash-memory-cost',
    // The hash parallelization must be a valid number.
    AUTH_INVALID_HASH_PARALLELIZATION = 'auth/invalid-hash-parallelization',
    // The hash rounds must be a valid number.
    AUTH_INVALID_HASH_ROUNDS = 'auth/invalid-hash-rounds',
    // The hashing algorithm salt separator field must be a valid byte buffer.
    AUTH_INVALID_HASH_SALT_SEPARATOR = 'auth/invalid-hash-salt-separator',
    // The provided ID token is not a valid Firebase ID token.
    AUTH_INVALID_ID_TOKEN = 'auth/invalid-id-token',
    // The last sign-in time must be a valid UTC date string.
    AUTH_INVALID_LAST_SIGN_IN_TIME = 'auth/invalid-last-sign-in-time',
    // The provided next page token in listUsers() is invalid. It must be a valid non-empty string.
    AUTH_INVALID_PAGE_TOKEN = 'auth/invalid-page-token',
    // The provided value for the password user property is invalid. It must be a string with at least six characters.
    AUTH_INVALID_PASSWORD = 'auth/invalid-password',
    // The password hash must be a valid byte buffer.
    AUTH_INVALID_PASSWORD_HASH = 'auth/invalid-password-hash',
    // The password salt must be a valid byte buffer
    AUTH_INVALID_PASSWORD_SALT = 'auth/invalid-password-salt',
    // The provided value for the phoneNumber is invalid. It must be a non-empty E.164 standard compliant identifier string.
    AUTH_INVALID_PHONE_NUMBER = 'auth/invalid-phone-number',
    // The provided value for the photoURL user property is invalid. It must be a string URL.
    AUTH_INVALID_PHOTO_URL = 'auth/invalid-photo-url',
    // The providerData must be a valid array of UserInfo objects.
    AUTH_INVALID_PROVIDER_DATA = 'auth/invalid-provider-data',
    // The providerId must be a valid supported provider identifier string.
    AUTH_INVALID_PROVIDER_ID = 'auth/invalid-provider-id',
    // Only exactly one OAuth responseType should be set to true.
    AUTH_INVALID_OAUTH_RESPONSE_TYPE = 'auth/invalid-oauth-responsetype',
    // The session cookie duration must be a valid number in milliseconds between 5 minutes and 2 weeks.
    AUTH_INVALID_SESSION_COOKIE_DURATION = 'auth/invalid-session-cookie-duration',
    // The provided uid must be a non-empty string with at most 128 characters.
    AUTH_INVALID_UID = 'auth/invalid-uid',
    // The user record to import is invalid.
    AUTH_INVALID_USER_IMPORT = 'auth/invalid-user-import',
    // The maximum allowed number of users to import has been exceeded.
    AUTH_MAX_USER_COUNT_EXCEEDED = 'auth/maximum-user-count-exceeded',
    // An Android Package Name must be provided if the Android App is required to be installed.
    AUTH_MISSING_ANDROID_PKG_NAME = 'auth/missing-android-pkg-name',
    // A valid continue URL must be provided in the request.
    AUTH_MISSING_CONTINUE_URI = 'auth/missing-continue-uri',
    // Importing users with password hashes requires that the hashing algorithm and its parameters be provided.
    AUTH_MISSING_HASH_ALGORITHM = 'auth/missing-hash-algorithm',
    // The request is missing a Bundle ID.
    AUTH_MISSING_IOS_BUNDLE_ID = 'auth/missing-ios-bundle-id',
    // A uid identifier is required for the current operation.
    AUTH_MISSING_UID = 'auth/missing-uid',
    // The OAuth configuration client secret is required to enable OIDC code flow.
    AUTH_MISSING_OAUTH_CLIENT_SECRET = 'auth/missing-oauth-client-secret',
    // The provided sign-in provider is disabled for your Firebase project.
    AUTH_OPERATION_NOT_ALLOWED = 'auth/operation-not-allowed',
    // The provided phoneNumber is already in use by an existing user. Each user must have a unique phoneNumber.
    AUTH_PHONE_NUMBER_ALREADY_EXIST = 'auth/phone-number-already-exists',
    // No Firebase project was found for the credential used to initialize the Admin SDKs.
    AUTH_PROJECT_NOT_FOUND = 'auth/project-not-found',
    // One or more custom user claims provided to setCustomUserClaims() are reserved.
    AUTH_RESERVED_CLAIMS = 'auth/reserved-claims',
    // The provided Firebase session cookie is expired.
    AUTH_SESSION_COOKIE_EXPIRED = 'auth/session-cookie-expired',
    // The Firebase session cookie has been revoked.
    AUTH_SESSION_COOKIE_REVOKED = 'auth/session-cookie-revoked',
    // The provided uid is already in use by an existing user. Each user must have a unique uid.
    AUTH_UID_ALREADY_EXIST = 'auth/uid-already-exists',
    // The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase Console.
    AUTH_UNAUTHORIZED_CONTINUE_URI = 'auth/unauthorized-continue-uri',
    // There is no existing user record corresponding to the provided identifier.
    AUTH_USER_NOT_FOUND = 'auth/user-not-found',
}
