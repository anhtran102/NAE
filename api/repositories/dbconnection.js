

// Connect to DB

var mysql = require('mysql');

var connection = mysql.createPool({
        host: 'localhost',
        user: 'root',
        password: 'admin',
        database: 'demo'
    });

   exports.getConnection = function (callback) {
        connection.getConnection(function (err, connection) {
            callback(err, connection);
        });
    }

    //module.exports = dbconnection;


