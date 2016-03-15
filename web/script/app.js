/**
 * Root app to load modules and route
 */
'use strict';

// Declare app level module which depends on filters, and services
angular.module('myApp.controllers', []);
angular.module('myApp.directives', []);
angular.module('myApp.services', []);
angular.module('myApp.filters', []);
angular.module('myApp', ['ngRoute',
  'myApp.controllers',  
  'myApp.services',
  'myApp.directives'
]).
config(function ($routeProvider) {
  $routeProvider.
    when('/products', {
      templateUrl: './html/products/products.html',
      controller: 'productController'
    }).
    when('/products/:id*', {
        templateUrl: './html/products/productdetails.html',
        controller: 'productdetailsController'
    }).
    otherwise({
      redirectTo: '/products'
    });  
});
