'use strict';

angular.module("myApp.directives")
    .controller("addreviewController", ["$scope", "$routeParams", "$http",
    function ($scope, $routeParams, $http) {
        $scope.review = {};
        $scope.addNewReview = function () {
            var baseUrl = "/api/reviews";
            var url = baseUrl;
            return $http.post(url, JSON.stringify($scope.review)).then(
                function (data) {
                    $scope.reviews.unshirt($scope.review);
                }
                , function (err) {
                    console.log(err);
                });
        };

    }]).directive('addreview', function () {
        return {
            restrict: "E",
            templateUrl: './html/products/addreview.html',
            controller: 'addreviewController'            
        }
    });
