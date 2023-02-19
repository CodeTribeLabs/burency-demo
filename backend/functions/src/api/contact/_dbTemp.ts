/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
import { Timestamp } from 'firebase-admin/firestore';

import { DbPaths } from '../../constants/db_path';

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
        changeList.push('firstName');
    }
    if (oldData.middleName !== newData.middleName) {
        changeList.push('middleName');
    }
    if (oldData.lastName !== newData.lastName) {
        changeList.push('lastName');
    }
    if (oldData.phone !== newData.phone) {
        changeList.push('phone');
    }
    if (oldData.address !== newData.address) {
        changeList.push('address');
    }
    if (oldData.note !== newData.note) {
        changeList.push('note');
    }
    if (oldData.geoHash !== newData.geoHash) {
        changeList.push('location');
    }

    return changeList.join(',');
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

        return { objectID };
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

        return { objectID };
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

        return { objectID };
    });
