
///**
// * Module dependencies
// */

//var express = require('express'),
//  bodyParser = require('body-parser'),
//  methodOverride = require('method-override'),
//  errorHandler = require('error-handler'),
//  morgan = require('morgan'),
//  routes = require('./routes'),
//  api = require('./routes/api'),
//  http = require('http'),
//  path = require('path');

//var app = express();


///**
// * Configuration
// */

//// all environments
//app.use(express.static(path.join(__dirname, 'public')));
////app.set('port', process.env.PORT || 3000);
////app.set('views', __dirname + '/views');
////app.set('view engine', 'jade');
//app.use(morgan('dev'));
////me app.use(bodyParser());
//app.use(bodyParser.urlencoded({ 'extended': 'true' })); //me
//app.use(bodyParser.json());// parse application/json
//app.use(bodyParser.json({ type: 'application/vnd.api+json' }));//me

//app.use(methodOverride());

//var env = process.env.NODE_ENV || 'development';

//// development only
//if (env === 'development') {
//  app.use(express.errorHandler());
//}

//// production only
//if (env === 'production') {
//  // TODO
//}


///**
// * Routes
// */

//// serve index and view partials
////app.get('/', routes.index);
////app.get('/partials/:name', routes.partials);

////// JSON API
////app.get('/api/name', api.name);

////// redirect all others to the index (HTML5 history)
////app.get('*', routes.index);


///**
// * Start Server
// */

////http.createServer(app).listen(app.get('port'), function () {
////  console.log('Express server listening on port ' + app.get('port'));
////});

// server.js

// set up ========================
var express = require('express');
var app = express();                               // create our app w/ express
var mongoose = require('mongoose');                     // mongoose for mongodb
var morgan = require('morgan');             // log requests to the console (express4)
var bodyParser = require('body-parser');    // pull information from HTML POST (express4)
var methodOverride = require('method-override'); // simulate DELETE and PUT (express4)

// configuration =================

mongoose.connect('mongodb://node:nodeuser@mongo.onmodulus.net:27017/uwO3mypu');     // connect to mongoDB database on modulus.io

app.use(express.static(__dirname + '/public'));                 // set the static files location /public/img will be /img for users
app.use(morgan('dev'));                                         // log every request to the console
app.use(bodyParser.urlencoded({ 'extended': 'true' }));            // parse application/x-www-form-urlencoded
app.use(bodyParser.json());                                     // parse application/json
app.use(bodyParser.json({ type: 'application/vnd.api+json' })); // parse application/vnd.api+json as json
app.use(methodOverride());

// listen (start app with node server.js) ======================================
app.listen(3000);
console.log("App listening on port 8080");

//var todo = {
//  text: String
//};

// define model =================
var todo = mongoose.model('Todo', {
    text: String
});
//routes
//api
//get all todos
app.get('/api/todos', function(req, res) {
    //get all todos
    todo.find(function(err, todos) {
        if (err) {
            res.send(err);
        }

        res.json(todos);// return all todos in JSON format
    });
});

app.post('/api/todos', function(req, res) {

    todo.create({
            text: req.body.text,
            done: false
        },
        function(err, todo) {
            if (err) {
                res.send(err);
            }

            todo.find(function(err2, todos) {
               if (err2) {
                   res.send(err2);
               }

                res.json(todos);
            });
        });
});