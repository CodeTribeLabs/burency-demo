export function replaceAll(value: string, search: string, replace: string): string {
    return value.split(search).join(replace);
}
