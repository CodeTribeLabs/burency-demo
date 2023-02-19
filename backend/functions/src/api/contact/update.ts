/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';
import * as geofire from 'geofire-common';
import { GeoPoint, Timestamp } from 'firebase-admin/firestore';

import { DbPaths } from '../../constants/db_path';
import { httpError, httpOk } from '../../helpers/http_commons';
import { FirebaseErrorData } from '../../models/http_result';
import { normalizePhone, validateFields, validateLocation } from './_commons';

export async function updateContact(uid:string, data: any) {
  try {
    const {
      id,
      firstName,
      middleName,
      lastName,
      phone,
      address,
      note,
      latitude,
      longitude,
    } = data;

    console.log(`>>> [${uid}] REQ: `, data);

    const normalizedPhone = normalizePhone(phone);
    let validationResult = validateFields(firstName, lastName, normalizedPhone);
    
    if (validationResult instanceof FirebaseErrorData) {
      throw validationResult;
    }

    validationResult = validateLocation(latitude, longitude);
    if (validationResult instanceof FirebaseErrorData) {
      throw validationResult;
    }

    const contact = {
      firstName,
      middleName: middleName ? middleName : '',
      lastName,
      phone: normalizedPhone,
      address: address ? address : '',
      note: note ? note : '',
      location: new GeoPoint(latitude, longitude),
      geoHash: geofire.geohashForLocation([latitude, longitude]),
      timestamp: Timestamp.now().toDate(),
    };

    const resp = await admin.firestore()
      .collection(DbPaths.CONTACTS)
      .doc(id)
      .set(contact);
    
    console.log(`>>> [${uid}] RESP: ${resp}`, contact);

    return httpOk({});
  } catch (error) {
    console.log('>>> REQUEST ERROR : ', error);
    return httpError(error);
  }
}
