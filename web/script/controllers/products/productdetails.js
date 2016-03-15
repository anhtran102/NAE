
angular.module("myApp.controllers").controller("productdetailsController", ["$scope", "$routeParams", "$http",
    function ($scope, $routeParams, $http) {
        var rootUrl = 'api/products/';
        var id = 0;
        $scope.reviews = [];
        $scope.init = function () {
            var url = "";
            if (!$routeParams.id) {
                id = 0;
            } else {
                id = $routeParams.id;
            }

            url = rootUrl + id;
            $http.get(url).then(
                function (data) {
                    $scope.product = data.data[0];
                    $scope.reviews = data.data[1]?data.data[1]: [];
                }, function (error) {
                    console.log(error);
                }
               );
        };

        $scope.init();
}]);