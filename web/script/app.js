'use strict';

// Declare app level module which depends on filters, and services

angular.module('myApp', ['ngRoute',
  'myApp.controllers',  
 // 'myApp.services',
  'myApp.directives'
]).
config(function ($routeProvider) {
  $routeProvider.
    when('/products', {
      templateUrl: './html/products/products.html',
      controller: 'productController'
    }).   
    otherwise({
      redirectTo: '/products'
    });  
});
