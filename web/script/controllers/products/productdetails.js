/**
 * product details controller to control events related to product details
 */
'use strict';
angular.module("myApp.controllers").controller("productdetailsController", ["$scope", "$routeParams", "productService",
    function ($scope, $routeParams, productservice) {
        var id = 0;
        $scope.reviews = [];
        $scope.initProductDetail = function () {
            if (!$routeParams.id) {
                id = 0;
            } else {
                id = $routeParams.id;
            }

            productservice.getProductById(id,
            function(err){

            },
            function(data){
                $scope.product = data.data[0][0];
                $scope.reviews = data.data[1]?data.data[1]: [];
            });
        };

        $scope.initProductDetail();
}]);