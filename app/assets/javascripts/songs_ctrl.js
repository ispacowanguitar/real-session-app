/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("songsCtrl", function($scope, $http, $sce) {
    $scope.setup = function() {
      $http.get("/api/user_id").then(function(response) {
        $scope.currentUser = response.data;
        $http.get("/api/songs/?user_id=" + $scope.currentUser.id + ".json").then(function(response) {
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
        $scope.previewUrl = $sce.trustAsResourceUrl(response.data["tracks"]["items"][0]["preview_url"]);
        // window.open($scope.previewUrl);
      });
      $scope.currentTitle = inputSong.title;
      $scope.currentComposer = inputSong.composer;
      $("#myModal").modal('show');
    };

    document.getElementById('audioClose').onclick = function() {
      var sounds = document.getElementsByTagName('audio');
      for (var i = 0; i < sounds.length; i++) {
        sounds[i].pause();
      }
    };

    window.$scope = $scope;
  });
})();
