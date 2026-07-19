const i18next = require('i18next');
const HttpBackend = require('i18next-http-backend');

i18next
  .use(HttpBackend)
  .init({
    fallbackLng: 'en',
    supportedLngs: ['en', 'es', 'fr', 'de', 'pt', 'ja', 'zh', 'ar', 'hi', 'ru'],
    backend: {
      loadPath: 'locales/{{lng}}/{{ns}}.json'
    },
    ns: ['common'],
    defaultNS: 'common'
  });

module.exports = i18next;
