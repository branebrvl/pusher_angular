(function () {
  'use strict';

  angular
    .module('app.admin')
    .controller('LoginController', LoginController);

  LoginController.$inject = ['$scope', 'auth', '$location'];

  function LoginController($scope, auth, $location) {
    var vm = this;

    vm.user = {
      email: '',
      password: ''
    };
    vm.wrongCredentials = false;

    vm.login = function () {
      if ($scope.loginForm.$valid) {
        auth.login(vm.user).then(success, error);
      } else {
        vm.loginForm.submitted = true;
      }
    };

    function success(response) {
      localStorage.setItem('auth_token', response.data.authToken);
      // $location.path('/admin');
    }

    function error(response) {
      vm.wrongCredentials = true;
    }
  }
})();
