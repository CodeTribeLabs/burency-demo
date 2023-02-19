/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as functions from 'firebase-functions';

import { Environment } from '../../constants/environment';
import { HttpResponseCode } from '../../constants/result_code';
import { validateRequest } from '../api_commons';
import { addContact } from './add';
import { deleteContact } from './delete';
import { searchContact, searchNearbyContact } from './search';
import { seedContact } from './seed';
import { updateContact } from './update';

exports.add = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('addContact', { structuredData: true });

        let resp = await validateRequest(request);
        if (resp.status === HttpResponseCode.ok) {
            resp = await addContact('', request.body);
        }

        response.status(resp.status).send(resp.data);
});

exports.update = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('updateContact', { structuredData: true });

        let resp = await validateRequest(request);
        if (resp.status === HttpResponseCode.ok) {
            resp = await updateContact('', request.body);
        }
        
        response.status(resp.status).send(resp.data);
});

exports.delete = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('deleteContact', { structuredData: true });

        let resp = await validateRequest(request);
        if (resp.status === HttpResponseCode.ok) {
            resp = await deleteContact('', request.body);
        }
        
        response.status(resp.status).send(resp.data);
});

exports.search = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('search', { structuredData: true });

        let resp = await validateRequest(request);
        if (resp.status === HttpResponseCode.ok) {
            resp = await searchContact('', request.body);
        }

        response.status(resp.status).send(resp.data);
});

exports.searchNearby = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('searchNearby', { structuredData: true });

        let resp = await validateRequest(request);
        if (resp.status === HttpResponseCode.ok) {
            const ipAddress = request.headers['x-appengine-user-ip'] || request.headers['x-forwarded-for'];
            resp = await searchNearbyContact(
                '',
                {
                    ...request.body,
                    ipAddress,
                });
        }

        response.status(resp.status).send(resp.data);
});

exports.seed = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('seedContact', { structuredData: true });

        let resp = await validateRequest(request);
        if (resp.status === HttpResponseCode.ok) {
            resp = await seedContact('', request.body);
        }

        response.status(resp.status).send(resp.data);
});
