/**
 *  store information for db server, host server
 */

'user strict'
var config = {
    //server db
    dbserver: {
        host: 'localhost',
        user: 'root',
        password: 'admin',
        database: 'demo'
    },
      //host server
    hostserver: {
            host: 'localhost',
            port: 3000
        }
};

module.exports = config;
