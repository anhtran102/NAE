/**
 * product service to handle business related to products
 */

'use strict';
var productRepository = require("../repositories/productRepository");
var connection = require("../repositories/dbconnection");
var productService = {
    getList: function (brandId, callback) {
        connection.getConnection(function (err, con) {
            if (err) {
                console.log(err);
                throw err;
            }

            productRepository.getList(brandId, con, function (err, data) {
                if (err) {
                    console.log(err);
                    throw err;
                }

                con.destroy();
                callback(err, data);
            });
        });
    },
    getProductById: function (id, callback) {
        connection.getConnection(function (err, con) {
            if (err) {
                console.log(err);
                throw err;
            }

            productRepository.getProductById(id, con, function (err, data) {
                if (err) {
                    console.log(err);
                    throw err;
                }

                con.destroy();
                callback(err, data);
            });
        });
    }
};

module.exports = productService;