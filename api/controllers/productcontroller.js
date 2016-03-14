
//Product controller

var productService = require("../services/productService");

var productController = {
    getList: function (req, res) {
        var brandId = req.query.brandId;
        productService.getList(brandId, function (err, data) {
            if (err) {
                console.log(err);
                throw err;
            }

            res.json(data);
        });
    },
    getProductById: function (req, res) {
        productService.getProductById(req.params.id, con, function (err, results) {
            if (err) {
                console.log(err);
            }

            res.json(results);
        });
    }
};

module.exports = productController;

