/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';
import { DbPaths } from '../../constants/db_path';
import { Environment } from '../../constants/environment';
import { FirebaseErrorCode } from '../../constants/result_code';
import { toHash } from '../../helpers/crypto_utils';
import { firebaseError, httpError, httpOk } from '../../helpers/http_commons';
import { validateEmail, validatePassword } from '../../helpers/validator';

export async function registerUser(data: any) {
  try {
    const {
      email,
      password,
    } = data;

    console.log('>>> REQ: ', data);
    
    let result = validateEmail(email);
    if (result !== '') {
      throw firebaseError(FirebaseErrorCode.AUTH_INVALID_EMAIL, result);
    }
    
    result = validatePassword(password);
    if (result !== '') {
      throw firebaseError(FirebaseErrorCode.AUTH_INVALID_PASSWORD, result);
    }

    const authUser = await admin.auth().createUser({
        email,
        password,
        emailVerified: false,
    });

    console.log('>>> RESP: ', authUser);

    const newContact = {
      digest: await toHash(password, Environment.API_KEY, authUser.uid),
      token: '',
    };

    await admin.firestore()
      .collection(DbPaths.USERS)
      .doc(authUser.uid)
      .set(newContact);

    return httpOk({});
  } catch (error) {
    console.log('>>> REQUEST ERROR : ', error);
    return httpError(error);
  }
}
