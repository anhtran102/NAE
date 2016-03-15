'use strict';

angular.module("myApp.controllers").controller("abc", ["$scope", "$routeParams", "$http",
    function ($scope, $routeParams, $http) {
        var rootUrl = 'api/products';
        $scope.review = {};
        $scope.init = function () {
            var url = "";
            $scope.product = {};
            var url = baseUrl + "/" + productId;
            $http.get(url).then(
            function (err) {

            },
            function (data) {
                if (data.data) {
                    $scope.product = data.data;
                    $scope.review = {
                        ProductId: $scope.product.productId,
                        UserId: 1
                    }
                };
            })
            ;
        };

        $scope.init();
    }])
