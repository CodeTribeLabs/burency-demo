import * as bcrypt from 'bcrypt';

function createKey(value: string, key: string, salt: string): string {
    return (value ?? '') + (salt ?? '') + key;
}

export async function toHash(value: string, key: string, salt: string): Promise<string> {
    return bcrypt.hash(createKey(value, key, salt), 10);
}

export async function verifyHash(hashedValue: string, value: string, key: string, salt: string): Promise<boolean> {
    return bcrypt.compare(createKey(value, key, salt), hashedValue);
}
