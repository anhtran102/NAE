/**
 * review directive
 */
'use strict';

angular.module("myApp.directives")
    .controller("reviewsController", ["$scope", "$routeParams", "$http",
    function ($scope, $routeParams, $http) {

    }]).directive('reviews',function () {
        return {
            restrict: "E",
            templateUrl: './html/products/reviews.html',
            controller: 'reviewsController',
            scope: {
                reviews:'='
            }
        }
    });
