const nodeUtilz = require('.././lib/nodeUtilz/app.js');


module.exports = async function test(array) {
  const networks = await Promise.all(
      array.map((d) => nodeUtilz.getScope(d))
  );
  // cleans up the data into a single array rather than what would have happend below...
  // notice the mask is messed up. need to update api to add training Zeros
  /*
  [ [ { ip: '11.23.2.2',
      mask: '255.255.128',
      network: '11.23.0.0',
      hosts: 32768 } ],
  [ { ip: '11.23.2.2',
      mask: '255.255.128',
      network: '11.23.0.0',
      hosts: 32768 } ] ]
  */
  const sigleArray = networks.reduce((n, o) => {
    n.push(...o);
    return n;
  }, []);
  return JSON.stringify(sigleArray);
};
