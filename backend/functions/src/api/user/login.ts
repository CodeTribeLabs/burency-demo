/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';
import { DbPaths } from '../../constants/db_path';
import { Environment } from '../../constants/environment';
import { ErrorCode } from '../../constants/result_code';
import { verifyHash } from '../../helpers/crypto_utils';
import { httpError, httpOk } from '../../helpers/http_commons';

export async function loginUser(data: any) {
  try {
    const {
      email,
      password,
    } = data;

    console.log('>>> REQ: ', data);

    // Must create Role and IAM permissions on GCP before hash data will be available
    // https://firebase.google.com/docs/auth/admin/manage-users#password_hashes_of_listed_users
    const authUser = await admin.auth().getUserByEmail(email);

    console.log('>>> RESP: ', authUser);

    const userDoc = await admin.firestore()
        .collection(DbPaths.USERS)
        .doc(authUser.uid)
        .get();

    if (userDoc.exists) {
        const user = userDoc.data();
        if (user) {
            const isPasswordValid = await verifyHash(user.digest, password, Environment.API_KEY, authUser.uid);

            if (isPasswordValid) {
                // NOTE:
                // This will only work if {project-name}@appspot.gserviceaccount.com principal
                // have on "Service Account Token Creator" role GCP console which have the required permissions:
                // iam.serviceAccounts.signBlob
                // iam.serviceAccounts.signJwt
                const token = await admin.auth().createCustomToken(authUser.uid);

                await admin.firestore()
                    .collection(DbPaths.USERS)
                    .doc(authUser.uid)
                    .set({
                        ...user,
                        token,
                    });

                return httpOk({
                    uid: authUser.uid,
                    token,
                });
            }
        }
    }

    return httpError(ErrorCode.AUTH_UNAUTHORIZED);
  } catch (error) {
    console.log('>>> REQUEST ERROR : ', error);
    return httpError(error);
  }
}
