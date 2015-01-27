(function () {
  'use strict';

  angular
    .module('app.admin')
    .controller('LogoutController', function (auth, $location) {
    auth.logout();
  });
})();
