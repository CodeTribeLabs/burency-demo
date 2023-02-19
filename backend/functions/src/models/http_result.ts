/* eslint-disable  @typescript-eslint/no-explicit-any */

export class HttpResult {
    status: number;
    data: any;

    constructor(status: number, data: any) {
        this.status = status;
        this.data = data;
    }
}

export class ErrorData {
    code: string;
    message: string;

    constructor(code: string, message: string) {
        this.code = code;
        this.message = message;
    }
}

export class FirebaseErrorData {
    errorInfo: ErrorData;

    constructor(code: string, message: string) {
        this.errorInfo = new ErrorData(code, message);
    }
}
