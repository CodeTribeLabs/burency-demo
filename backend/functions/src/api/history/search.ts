/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';
import { DbPaths } from '../../constants/db_path';
import { httpError, httpOk } from '../../helpers/http_commons';

export async function searchHistory(uid:string, data: any) {
  try {
    const {
      id,
      sortDesc,
      limit,
      page,
    } = data;

    console.log(`>>> [${uid}] REQ: `, data);

    const sortOrder = sortDesc && sortDesc === true ? 'desc' : 'asc';
    const count = limit && limit > 0 ? limit : 10;
    const pageOffset = page && page > 0 ? count * page : 0;

    let resp;
    const query = admin.firestore()
        .collection(DbPaths.HISTORY)
        .orderBy('timestamp', sortOrder)
        .limit(count)
        .offset(pageOffset);
    
    if (id === '') {
      resp = await query.get();
    } else {
      resp = await query
        .where('id', '==', id)
        .get();
    }

    const docs:any[] = [];
    resp.forEach((doc) => {
      docs.push({
        docId: doc.id,
        ...doc.data(),
      });
    });

    console.log(`>>> [${uid}] RESP: ${resp}`);

    return httpOk(docs);
  } catch (error) {
    console.log('>>> REQUEST ERROR : ', error);
    return httpError(error);
  }
}
