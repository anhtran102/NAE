/**
 * product controller to control events related to product details
 */
'use strict';
angular.module("myApp.controllers").controller("productController", ["$scope","$routeParams","productService",
    function ($scope, $routeParams, productservice) {
        var brandId = 0;
        $scope.init = function () {
            $scope.products = [];
            if (!$routeParams.brandId) {
                brandId = 0;
            } else {
                if(parseInt($routeParams.brandId, 10)){
                    brandId = parseInt($routeParams.brandId, 10);
                }               
            }

            productservice.getProducts(brandId,
            function(){

            }, function(data){
                    $scope.products = data.data;
                });
        };

        $scope.init();
    }]);
