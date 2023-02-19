import * as functions from 'firebase-functions';

import { Environment } from '../../constants/environment';
import { ErrorCode } from '../../constants/result_code';
import { httpError } from '../../helpers/http_commons';

import { searchHistory } from './search';

exports.search = functions
  .region(Environment.REGION)
  .https.onCall(async (data, context) => {
    // const opCode = 'search';
    
    if (!context.auth) {
      return httpError(ErrorCode.AUTH_UNAUTHORIZED);
    }

    return await searchHistory(context.auth.uid, data);
  });

