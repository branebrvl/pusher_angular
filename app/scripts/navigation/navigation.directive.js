(function () {
  'use strict';

  angular
    .module('app.navigation')
    .directive('navbar', navbar);

  function navbar() {
    return {
      restrict: 'E',
      templateUrl: 'scripts/navigation/navbar.html',
      controller: 'NavigationController',
      controllerAs: 'vm'
    };
  }
})();
