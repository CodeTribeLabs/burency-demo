/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
import { Timestamp } from 'firebase-admin/firestore';
import algoliasearch from 'algoliasearch';

import { DbPaths } from '../../constants/db_path';

// Set keys using:
// > firebase functions:config:set algolia.app={APP_ID} algolia.key={ADMIN_KEY}
const APP_ID = functions.config().algolia.app;
const ADMIN_KEY = functions.config().algolia.key;

const client = algoliasearch(APP_ID, ADMIN_KEY);
const index = client.initIndex(DbPaths.CONTACTS);

async function logChanges(type:string, data:any) {
    const logEntry = {
        ...data,
        type,
        timestamp: Timestamp.now().toDate(),
      };
  
    await admin.firestore()
        .collection(DbPaths.HISTORY)
        .doc()
        .set(logEntry);
}

function getChanges(oldData:any, newData:any): string {
    const changeList = [];

    if (oldData.firstName !== newData.firstName) {
        changeList.push('First Name');
    }
    if (oldData.middleName !== newData.middleName) {
        changeList.push('Middle Name');
    }
    if (oldData.lastName !== newData.lastName) {
        changeList.push('Last Name');
    }
    if (oldData.phone !== newData.phone) {
        changeList.push('Phone');
    }
    if (oldData.address !== newData.address) {
        changeList.push('Address');
    }
    if (oldData.note !== newData.note) {
        changeList.push('Note');
    }
    if (oldData.geoHash !== newData.geoHash) {
        changeList.push('Location');
    }

    return changeList.join(', ');
}

exports.onAdd = functions
    .firestore
    .document(`${DbPaths.CONTACTS}/{id}`)
    .onCreate(async (snapshot) => {
        const data = snapshot.data();
        const objectID = snapshot.id;

        await logChanges(
            'ADD_CONTACT',
            {
                id: objectID,
                phone: data.phone,
                changes: '',
            },
        );

        return index.saveObject({
            ...data,
            objectID,
            _geoloc: {
                lat: data.location.latitude,
                lng: data.location.longitude,
            },
         });
    });

exports.onUpdate = functions
    .firestore
    .document(`${DbPaths.CONTACTS}/{id}`)
    .onUpdate(async (change) => {
        const oldData = change.before.data();
        const newData = change.after.data();
        const objectID = change.after.id;

        await logChanges(
            'UPDATE_CONTACT',
            {
                id: objectID,
                phone: newData.phone,
                changes: getChanges(oldData, newData),
            },
        );

        return index.saveObject({
            ...newData,
            objectID,
            _geoloc: {
                lat: newData.location.latitude,
                lng: newData.location.longitude,
            },
        });
    });

exports.onDelete = functions
    .firestore
    .document(`${DbPaths.CONTACTS}/{id}`)
    .onDelete(async (snapshot) => {
        const data = snapshot.data();
        const objectID = snapshot.id;

        await logChanges(
            'DELETE_CONTACT',
            {
                id: objectID,
                phone: data.phone,
                changes: '',
            },
        );

        return index.deleteObject(objectID);
    });
