var express = require("express");
var app = express();
var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded());
app.use(bodyParser.json());
app.use('/', express.static('./'));
app.use(express.static(__dirname + '/public'));
app.use(express.static(__dirname + '/public/html'));

app.get('/', function (req, res) {
    res.sendFile('/index.html');    
});

app.get('/api/product', function (req, res) {
    res.send("products");
});



app.listen(3000);
console.log("Running at Port 3000");