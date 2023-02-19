/* eslint-disable  @typescript-eslint/no-explicit-any */

// import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
// import * as geofire from 'geofire-common';
import algoliasearch from 'algoliasearch';

import { DbPaths } from '../../constants/db_path';
import { httpError, httpOk } from '../../helpers/http_commons';
import { validateLocation } from './_commons';
import { FirebaseErrorData } from '../../models/http_result';

// Set keys using:
// > firebase functions:config:set algolia.app={APP_ID} algolia.key={ADMIN_KEY}
const APP_ID = functions.config().algolia.app;
const ADMIN_KEY = functions.config().algolia.key;

const client = algoliasearch(APP_ID, ADMIN_KEY);
const index = client.initIndex(DbPaths.CONTACTS);

export async function searchContact(uid:string, data: any) {
  try {
    const {
      query,
      searchFields,
      latitude,
      longitude,
      radiusInMeters,
      limit,
      page,
    } = data;

    console.log(`>>> [${uid}] REQ: `, data);

    let searchableAttributes = [
      'firstName',
      'middleName',
      'lastName',
      'address',
      'note',
      'phone',
    ];

    if (searchFields && Array.isArray(searchFields) && searchFields.length > 0) {
      searchableAttributes = searchFields;
    }

    index.setSettings({
      searchableAttributes,
    });

    let options: any = {
      page: page && page > 0 ? page : 0,
      hitsPerPage: limit && limit > 0 ? limit : 10,
    };

    if (latitude && longitude && radiusInMeters) {
      const validationResult = validateLocation(latitude, longitude);
      
      if (validationResult instanceof FirebaseErrorData) {
        throw validationResult;
      }

      options = {
        ...options,
        aroundLatLng: `${latitude}, ${longitude}`,
        aroundRadius: radiusInMeters,
      };
    }

    const resp = await index.search(query, options);

    console.log(`>>> [${uid}] RESP: ${resp}`);

    return httpOk(resp);
  } catch (error) {
    console.log('>>> REQUEST ERROR : ', error);
    return httpError(error);
  }
}

export async function searchNearbyContact(uid:string, data: any) {
  try {
    const {
      ipAddress,
      radiusInMeters,
      limit,
      page,
    } = data;

    console.log(`>>> [${uid}] REQ: `, data);

    const options = {
      page: page && page > 0 ? page : 0,
      hitsPerPage: limit && limit > 0 ? limit : 10,
      aroundLatLngViaIP: true,
      aroundRadius: radiusInMeters ? radiusInMeters : 0,
      headers: {
        'X-Forwarded-For': ipAddress,
      },
    };

    const resp = await index.search('', options);

    console.log(`>>> [${uid}] RESP: ${resp}`);

    return httpOk(resp);
  } catch (error) {
    console.log('>>> REQUEST ERROR : ', error);
    return httpError(error);
  }
}

// Search using Firebase GeoPoint
// Find cities within 50km of London
// const center:geofire.Geopoint = [latitude, longitude];

// Each item in 'bounds' represents a startAt/endAt pair. We have to issue
// a separate query for each pair. There can be up to 9 pairs of bounds
// depending on overlap, but in most cases there are 4.
// const bounds = geofire.geohashQueryBounds(center, radiusInMeters);
// const promises = [];
// for (const b of bounds) {
//     const q = admin.firestore()
//         .collection(DbPaths.CONTACTS)
//         .orderBy('geoHash')
//         .startAt(b[0])
//         .endAt(b[1]);

//     promises.push(q.get());
// }

// // Collect all the query results together into a single list
// const resp = await Promise.all(promises).then((snapshots) => {
//     const matchingDocs = [];

//     for (const snap of snapshots) {
//         for (const doc of snap.docs) {
//             const lat = doc.get('lat');
//             const lng = doc.get('lng');

//             // We have to filter out a few false positives due to GeoHash
//             // accuracy, but most will match
//             const distanceInKm = geofire.distanceBetween([lat, lng], center);
//             const distanceInM = distanceInKm * 1000;
//             if (distanceInM <= radiusInMeters) {
//                 matchingDocs.push(doc);
//             }
//         }
//     }

//     return matchingDocs;
// });
