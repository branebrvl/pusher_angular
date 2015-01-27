(function () {
  'use strict';

  angular
    .module('app.admin')
    .service('auth', auth);
    
    auth.$inject = ['$http'];

    function auth($http) {
      this.login = function (user) {
        return $http.post('/api/login', {
          email: user.email,
          password: user.password
        });
      };

      this.isLoggedIn = function () {
        return (localStorage.getItem('auth_token')) ? true : false;
      };
  }
})();
