/* eslint-disable  @typescript-eslint/no-explicit-any */

import { FirebaseErrorCode } from '../../constants/result_code';
import { firebaseError } from '../../helpers/http_commons';
import { replaceAll } from '../../helpers/string_utils';
import { validateGeoLocation, validateName, validatePhone } from '../../helpers/validator';

export function normalizePhone(phone: string): string {
    // let normalized = phone.replace(' ', '');
    // normalized = phone.replace('-', '');
    // normalized = phone.replace('(', '');
    // normalized = phone.replace(')', '');

    return replaceAll(phone, ' ', '');
}

export function validateFields(firstName: string, lastName: string, phone: string): any {
    let result = validateName(firstName);
    if (result !== '') {
      return firebaseError(FirebaseErrorCode.AUTH_INVALID_DISPLAY_NAME, result);
    }

    result = validateName(lastName);
    if (result !== '') {
      return firebaseError(FirebaseErrorCode.AUTH_INVALID_DISPLAY_NAME, result);
    }

    result = validatePhone(phone);
    if (result !== '') {
      return firebaseError(FirebaseErrorCode.AUTH_INVALID_PHONE_NUMBER, result);
    }

    return '';
}

export function validateLocation(latitude: number, longitude: number): any {
    const result = validateGeoLocation(latitude, longitude);
    if (result !== '') {
      return firebaseError(FirebaseErrorCode.AUTH_INVALID_ARGUMENT, result);
    }

    return '';
}
