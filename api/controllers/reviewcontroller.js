

var reviewService = require("../services/reviewservice");

var reviewController = {
    createReview: function (req, res) {
        var review = req.body;
        reviewService.createReview(review, function (err, results) {
            if (err) {
                console.log(err);
                throw err;
            }

            res.json(results);
        });
    }
};

module.exports = reviewController;