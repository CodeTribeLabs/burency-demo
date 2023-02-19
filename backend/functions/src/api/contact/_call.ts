import * as functions from 'firebase-functions';

import { Environment } from '../../constants/environment';
import { ErrorCode } from '../../constants/result_code';
import { httpError } from '../../helpers/http_commons';

import { addContact } from './add';
import { updateContact } from './update';
import { deleteContact } from './delete';
import { searchContact, searchNearbyContact } from './search';

exports.add = functions
  .region(Environment.REGION)
  .https.onCall(async (data, context) => {
    // const opCode = 'addContact';
    if (!context.auth) {
      return httpError(ErrorCode.AUTH_UNAUTHORIZED);
    }

    return await addContact(context.auth.uid, data);
  });

exports.update = functions
  .region(Environment.REGION)
  .https.onCall(async (data, context) => {
    // const opCode = 'updateContact';
    if (!context.auth) {
      return httpError(ErrorCode.AUTH_UNAUTHORIZED);
    }
      
    return await updateContact(context.auth.uid, data);
  });

exports.delete = functions
  .region(Environment.REGION)
  .https.onCall(async (data, context) => {
    // const opCode = 'deleteContact';
    
    if (!context.auth) {
      return httpError(ErrorCode.AUTH_UNAUTHORIZED);
    }

    return await deleteContact(context.auth.uid, data);
  });

exports.search = functions
  .region(Environment.REGION)
  .https.onCall(async (data, context) => {
    // const opCode = 'search';
    
    if (!context.auth) {
      return httpError(ErrorCode.AUTH_UNAUTHORIZED);
    }

    return await searchContact(context.auth.uid, data);
  });

exports.searchNearby = functions
  .region(Environment.REGION)
  .https.onCall(async (data, context) => {
    // const opCode = 'searchNearby';
    
    const headers = context.rawRequest.headers;
    const ipAddress = headers['x-appengine-user-ip'] || headers['x-forwarded-for'];

    if (!context.auth) {
      return httpError(ErrorCode.AUTH_UNAUTHORIZED);
    }

    return await searchNearbyContact(
      context.auth.uid,
      {
        ...data,
        ipAddress,
      });
  });
