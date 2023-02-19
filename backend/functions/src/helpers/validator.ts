export function validateGeoLocation(latitude: number, longitude: number) : string {
    if (latitude < -90 || latitude > 90) {
        return 'Latitude must be within the range -90 to 90';
    }

    if (longitude < -180 || longitude > 180) {
        return 'Latitude must be within the range -180 to 180';
    }

    return '';
}

export function validateEmail(email: string): string {
    const result = validatePattern(email, /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i);
    return result ? '' : 'Invalid email format';
}

export function validatePassword(password: string): string {
    let result = validatePattern(password, /^\S{8,30}$/m);

    if (result) {
        result = validatePattern(password, /.*[A-Z]/);
        if (result) {
            result = validatePattern(password, /^.*[a-z]/);
            if (result) {
                result = validatePattern(password, /.*[\d]/);
                if (result) {
                    // result = validatePattern(password, /.*[~!@#$%^*\-_=+[{\]}\/;:,.?]/);
                    result = validatePattern(password, /.*[~!@#$%^*\-_=+[{\]}/;:,.?]/);
                    if (result) {
                        return '';
                    } else {
                        return 'Must have at least 1 special character';
                    }
                } else {
                    return 'Must have at least 1 numeric character';
                }
            } else {
                return 'Must have at least 1 lowercase letter';
            }
        } else {
            return 'Must have at least 1 uppercase letter';
        }
    } else {
        return 'Must be at least 8 characters';
    }
}

export function validatePhone(phone: string): string {
    // const result = validatePattern(phone, /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im);
    const result = validatePattern(phone, /^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$/im);
    return result ? '' : 'Invalid phone number format';
}

export function validateName(name: string): string {
    const result = validatePattern(name, /^[A-Za-z-]+$/);
    return result ? '' : 'Invalid name format';
}

function validatePattern(value: string, pattern: RegExp): boolean {
    return pattern.test(value);
}
