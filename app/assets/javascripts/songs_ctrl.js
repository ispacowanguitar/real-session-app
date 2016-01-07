(function() {
  "use strict";
  angular.module("app").controller("songsCtrl", function($scope, $http) {
    $scope.setup = function() {
      $http.get('/api/songs.json').then(function(response) {
        console.log(response);
        $scope.songs = response.data;
      });
    };
    window.$scope = $scope;
  });
})();