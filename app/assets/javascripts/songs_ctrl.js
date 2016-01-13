/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("songsCtrl", function($scope, $http, $sce) {
    console.log($sce.trustAsResourceUrl);
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

    $scope.playSong = function(inputSong) {
      var title = inputSong.title.split(" ").join("%20");
      $http.get("https://api.spotify.com/v1/search?query=" + title + "&type=track&limit=1").then(function(response) {
        $scope.previewUrl = response.data["tracks"]["items"][0]["preview_url"];
        window.open($scope.previewUrl);
      });
    };

    window.$scope = $scope;
  });
})();