/**
 * add review directive
 */
'use strict';
angular.module("myApp.directives")
    .controller("addreviewController", ["$scope", "$routeParams", "$http",
    function ($scope, $routeParams, $http) {
        $scope.review = {};
        $scope.review.ProductId = $routeParams.id;
        $scope.review.UserId = 1;
        $scope.addNewReview = function () {
            var baseUrl = "/api/reviews";
            return $http.post(baseUrl, JSON.stringify($scope.review)).then(
                function () {
                    if ($scope.reviews) {
                        $scope.reviews = [];
                    }
                    $scope.reviews.push($scope.review);
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
