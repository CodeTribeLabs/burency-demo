/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';
import * as geofire from 'geofire-common';
import { faker } from '@faker-js/faker';
import { GeoPoint, Timestamp } from 'firebase-admin/firestore';

import { Environment } from '../../constants/environment';
import { DbPaths } from '../../constants/db_path';
import { FirebaseErrorCode } from '../../constants/result_code';
import { firebaseError, httpError, httpOk } from '../../helpers/http_commons';

export async function seedContact(uid:string, data: any) {
  try {
    const {
        apiKey,
        count,
    } = data;

    console.log(`>>> [${uid}] REQ: `, data);

    if (apiKey !== Environment.API_KEY) {
      throw firebaseError(FirebaseErrorCode.AUTH_INVALID_API_KEY, '');
    }

    const writeBatch = admin.firestore().batch();

    Array(count).fill(0).forEach(() => {
        const docRef = admin.firestore().collection(DbPaths.CONTACTS).doc();
        writeBatch.set(docRef, createRandomUser());
    });
    
    const resp = await writeBatch.commit();
    console.log(`>>> [${uid}] RESP: ${resp}`);

    return httpOk({});
  } catch (error) {
    console.log('>>> REQUEST ERROR : ', error);
    return httpError(error);
  }
}

function createRandomUser(): any {
    const latitude = parseFloat(faker.address.latitude());
    const longitude = parseFloat(faker.address.longitude());
    const address = `${faker.address.streetAddress()}, ${faker.address.cityName()}, ${faker.address.state()}, ${faker.address.country()}`;
    
    return {
        firstName: faker.name.firstName(),
        middleName: faker.name.middleName(),
        lastName: faker.name.lastName(),
        phone: faker.phone.number('+############'),
        address,
        note: faker.name.jobTitle(), // faker.company.catchPhrase(),
        location: new GeoPoint(latitude, longitude),
        geoHash: geofire.geohashForLocation([latitude, longitude]),
        timestamp: Timestamp.now().toDate(),
  };
}
