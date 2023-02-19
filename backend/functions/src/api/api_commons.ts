/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';

import { ErrorCode } from '../constants/result_code';
import { httpError, httpOk } from '../helpers/http_commons';
import { HttpResult } from '../models/http_result';
import { DbPaths } from '../constants/db_path';

export async function validateRequest(request: any): Promise<HttpResult> {
    if (request.method === 'POST') {
        const {
            uid,
        } = request.body;

        try {
            const token = request.headers.authorization?.split('Bearer ')[1];
            if (token) {
                const isValid = await validateToken(uid, token);
                if (isValid) {
                    return httpOk({});
                }
            }
        } catch (e) {
            return httpError(ErrorCode.AUTH_UNAUTHORIZED);
        }
    }

    return httpError(ErrorCode.AUTH_UNAUTHORIZED);
}

async function validateToken(id: string, token: string) {
    // Alternative way to verify Bearer token:
    // https://jsmobiledev.com/article/secure-functions/

    const userDoc = await admin.firestore()
        .collection(DbPaths.USERS)
        .doc(id)
        .get();
    
    if (userDoc.exists) {
        const user = userDoc.data();
        
        if (user) {
            return user.token === token;
        }
    }

    return false;
}
