

var reviewService = require("../services/reviewservice");

var reviewController = {
    createReview: function (req, res) {
        var review = req.body;
        reviewService.createReview(review, con, function (err, results) {
            if (err) {
                console.log(err);
                throw err;
            }

            con.release();
            res.json(results);
        });
    }
};

module.exports = reviewController;