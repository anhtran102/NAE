//manipulation to DB

var productRepository = {
    getList: function (brandId, con, callback) {
        if (!brandId) {
            brandId = 0;
        }

        con.query('CALL sp_getListProducts(' + brandId + ')', function (err, data) {        
            //console.log(data);
            callback(err, data[0]);
        });
    },
    getProductById: function (id, con, callback) {
        con.query('CALL sp_getProductDetails('+id+')', function (err, data) {
            callback(err, data[0]);
        });
    }
};

module.exports = productRepository;
