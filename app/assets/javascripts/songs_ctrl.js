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

    $scope.testFunction = function(word) {
      console.log(word);
    };

    $scope.playSong = function(inputSong) {
      console.log("inputSong");
      var title = inputSong.title.split(" ").join("%20");
      $http.get("https://api.spotify.com/v1/search?query=" + title + "&type=track&limit=1").then(function(response) {
        $scope.previewUrl = $sce.trustAsResourceUrl(response.data["tracks"]["items"][0]["preview_url"]);
      });
      $scope.currentTitle = inputSong.title;
      $scope.currentComposer = inputSong.composer;
      $("#myModal").modal('show');
    };

    $scope.seachSongs = function(searchInput) {
      console.log(searchInput);
    };

    document.getElementById('audioClose').onclick = function() {
      var sounds = document.getElementsByTagName('audio');
      for (var i = 0; i < sounds.length; i++) {
        sounds[i].pause();
      }
    };

    $scope.findUsers = function(searchInput) {
      var urlName = searchInput.split(" ").join("%20");
      $http.get("/api/user_id/?user_name=" + urlName).then(function(response) {
        console.log(response.data);
        $scope.usersArray = response.data;
      });
    };

    $scope.showSongs = function(inputUser) {
      console.log(inputUser.id);
      $scope.showUserSongs = true;
      $http.get("/api/songs/?user_id=" + inputUser.id + ".json").then(function(response) {
        $scope.userSongs = response.data;
        console.log($scope.userSongs);
        $scope.totalUserSongs = $scope.userSongs["song_array"].length;
      });
    };

    window.$scope = $scope;
  });
})();
