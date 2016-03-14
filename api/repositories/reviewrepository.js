

var reviewRepository = {
    createReview: function (review, con, callback) {
        con.query('INSERT INTO preview SET ?', review, function (err, data) {
            callback(err, data);
        });
    }
}

module.exports = reviewRepository;