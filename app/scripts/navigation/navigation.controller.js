(function () {
  'use strict';

  angular
    .module('app.navigation')
    .controller('NavigationController', NavigationController);

  NavigationController.$inject = ['$scope', 'auth', '$location'];

  function NavigationController($scope, auth, $location) {
    var vm = this;

    vm.isLoggedIn = auth.isLoggedIn;

    vm.isActive = function (path) {
      if (!$location.path()) {return;}
      var currentPath = $location.path().split('/')[1].split('?')[0];
      return currentPath === path.split('/')[1];
    };

    vm.logout = function () {
      auth.logout().then(function () {
        localStorage.removeItem('auth_token');
        $location.path('/login');
      });
    };
  }
})();
