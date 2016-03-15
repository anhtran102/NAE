
/**
 * Config and methods to get connection Database
 */
'use strict';
var mysql = require("mysql");
var config = require("../config");

var connection = mysql.createPool({
        host: config.dbserver.host,
        user: config.dbserver.user,
        password: config.dbserver.password,
        database: config.dbserver.database
    });

   exports.getConnection = function (callback) {
        connection.getConnection(function (err, connection) {
            callback(err, connection);
        });
    };


