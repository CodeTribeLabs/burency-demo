/* eslint-disable  @typescript-eslint/no-explicit-any */

import * as functions from 'firebase-functions';

import { Environment } from '../../constants/environment';
import { ErrorCode } from '../../constants/result_code';
import { httpError } from '../../helpers/http_commons';
import { loginUser } from './login';
import { registerUser } from './register';

exports.register = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('registerUser', { structuredData: true });

        let resp;
        if (request.method === 'POST') {
            resp = await registerUser(request.body);
        } else {
            resp = httpError(ErrorCode.AUTH_UNAUTHORIZED);
        }

        response.status(resp.status).send(resp.data);
});

exports.login = functions
    .region(Environment.REGION)
    .https.onRequest(async (request, response) => {
        functions.logger.info('loginUser', { structuredData: true });

        let resp;
        if (request.method === 'POST') {
            resp = await loginUser(request.body);
        } else {
            resp = httpError(ErrorCode.AUTH_UNAUTHORIZED);
        }

        response.status(resp.status).send(resp.data);
});
