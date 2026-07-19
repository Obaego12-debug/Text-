module.exports = {
  testEnvironment: 'node',
  collectCoverageFrom: ['src/**/*.js', '!src/**/*.test.js'],
  setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],
  testMatch: ['**/tests/**/*.test.js'],
  coverageDirectory: 'coverage',
  testTimeout: 10000
};