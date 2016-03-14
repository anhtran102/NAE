
//Service

var reviewRepository = require("../repositories/reviewRepository");
var connection = require("../repositories/dbconnection");
var reviewService = {
    createReview: function (brandId, callback) {
        connection.getConnection(function (err, con) {
            if (err) {
                console.log(err);
                throw err;
            }

            reviewRepository.createReview(review, con, function (err, data) {
                if (err) {
                    //console.log(err);
                    throw err;
                }

                con.destroy();
                callback(err, data);
            });
        });
    }
}

module.exports = reviewService;