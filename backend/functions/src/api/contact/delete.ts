/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';

import { DbPaths } from '../../constants/db_path';
import { httpError, httpOk } from '../../helpers/http_commons';

export async function deleteContact(uid:string, data: any) {
    try {
        const {
            id,
        } = data;

        console.log(`>>> [${uid}] REQ: `, data);

        const resp = await admin.firestore()
            .collection(DbPaths.CONTACTS)
            .doc(id)
            .delete();

        console.log(`>>> [${uid}] RESP: ${resp}`);

        return httpOk({});
    } catch (error) {
        console.log('>>> REQUEST ERROR : ', error);
        return httpError(error);
    }
}
