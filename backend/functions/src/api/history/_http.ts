/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as functions from 'firebase-functions';

import { Environment } from '../../constants/environment';
import { HttpResponseCode } from '../../constants/result_code';
import { validateRequest } from '../api_commons';
import { searchHistory } from './search';

exports.search = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('searchHistory', { structuredData: true });

        let resp = await validateRequest(request);
        if (resp.status === HttpResponseCode.ok) {
            resp = await searchHistory('', request.body);
        }

        response.status(resp.status).send(resp.data);
});
