module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:import/errors',
    'plugin:import/warnings',
    'plugin:import/typescript',
    'google',
    'plugin:@typescript-eslint/recommended',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: ['tsconfig.json', 'tsconfig.dev.json'],
    tsconfigRootDir: __dirname,
    sourceType: 'module',
  },
  ignorePatterns: [
    '/lib/**/*', // Ignore built files.
  ],
  plugins: [
    '@typescript-eslint',
    'import',
  ],
  rules: {
    '@typescript-eslint/no-explicit-any': 'warn', // off
    'quotes': [2, 'single', 'avoid-escape'],
    'import/no-unresolved': 0,
    'comma-dangle': ['error', 'always-multiline'],
    'object-curly-spacing': ['error', 'always'],
    'no-trailing-spaces': ['error', {
      'skipBlankLines': true,
      'ignoreComments': true,
    }],
    'indent': 'off',
    'max-len': ['error', { 'code': 160 }],
    'linebreak-style': 0,
    'require-jsdoc': 0,
  },
};
