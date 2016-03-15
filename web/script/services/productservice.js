/**
 * Service to call api
 */
'use strict';
angular.module("myApp.services").factory("productService",  ['$http',
    function ($http) {
    'use strict';
    var baseUrl = "/api/products";
    return {
        getProducts: function (brandId, err, success) {
            var url = baseUrl + "?brandId=" + brandId;
            return $http.get(url).then(success);
        },
        getProductById: function (productId,err, success) {
            var url = baseUrl + "/" + productId;
            return $http.get(url).then(success);
        }
    };
}]);
