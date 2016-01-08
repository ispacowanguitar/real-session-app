/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("songsCtrl", function($scope, $http) {
    $scope.setup = function() {
      $http.get("/api/user_id").then(function(response) {
        console.log(response);
        $scope.currentUser = response.data;
        $http.get("/api/songs/?user_id=" + $scope.currentUser.id + ".json").then(function(response) {
          console.log(response);
          $scope.songs = response.data;
        });
      });
    };

    $scope.sortBy = function(style) {
      console.log(style);
      if (style === 'all') {
        $scope.sortStyle = undefined;
      } else {
        $scope.sortStyle = String(style);
      }
    };

    window.$scope = $scope;
  });
})();