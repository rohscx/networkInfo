'use strict';
const netInfo = require('./api/netInfo.js');

const Hapi = require('hapi');

const init = async () => {
  const server = Hapi.server({
    port: 3000,
    host: '0.0.0.0',
  });


  server.route({
    method: 'GET',
    path: '/',
    handler: async (request, h) => {
    // request.log(['a', 'name'], "Request name");
    // or
      const params = request.query;
      const {ipCidr = []} = params;
      if (ipCidr.length > 0) {
        // make a test for this
        const splitCidr = ipCidr.split(',');
        return await netInfo(splitCidr);
      } else {
        return `acceptable Parameters: /?ipCidr= x.x.x.x/x e.g. /?ipCidr=12.1.2.3/17`;
      }
      request.logger.info('In handler %s', request.path);
      // return 'Hello, ' + await netInfo(request.params.network) + '!';
    },
  });

  await server.register({
    plugin: require('hapi-pino'),
    options: {
      prettyPrint: true,
      logEvents: ['response', 'onPostStart'],
    },
  });

  await server.start();
  console.log(`Server running at: ${server.info.uri}`);
};

process.on('unhandledRejection', (err) => {
  console.log(err);
  process.exit(1);
});

process.on('unhandledRejection', (err) => {
  console.log(err);
  process.exit(1);
});

init();
