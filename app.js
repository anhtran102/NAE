'use strict';

var express = require("express");
var app = express();
var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded());
app.use(bodyParser.json());
app.use('/', express.static('./'));
app.use(express.static(__dirname + '/web'));
app.use(express.static(__dirname + '/web/html'));
app.use(express.static(__dirname + '/web/images'));
app.use(express.static(__dirname + '/web/script'));

app.get('/', function (req, res) {
    res.sendFile('/web/index.html');    
});

var productController = require("./api/controllers/productController");
var reviewController = require("./api/controllers/reviewController");
app.route('/api/products')
    .get(productController.getList);

app.route('/api/products/:id')
    .get(productController.getProductById);

app.route('/api/reviews')
    .post(reviewController.createReview);

var config = require('./api/config');
app.listen(config.hostserver.port);
console.log("Running at Port"+config.hostserver.port);