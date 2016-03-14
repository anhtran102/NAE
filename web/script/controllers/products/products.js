'use strict';

angular.module("myApp.controllers", []).controller("productController", ["$scope","$routeParams",'$http',
    function ($scope, $routeParams, $http) {
        var rootUrl = 'api/products';
        var brandId = 0;
        $scope.init = function () {
            var url = "";
            $scope.products = [];
            if (!$routeParams.brandId) {
                brandId = 0;
            } else {
                if(parseInt($routeParams.brandId, 10)){
                    brandId = parseInt($routeParams.brandId, 10);
                }               
            }
            url = rootUrl + "?brandId=" + brandId;
            $http.get(url).then(
                function (data) {
                    $scope.products = data.data;
                }, function (error) {
                }
               );
        };

        $scope.init();
    }]);
