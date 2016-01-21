/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("songsCtrl", function($scope, $http, $sce) {
    $scope.setup = function() {
      $http.get("/api/user_id").then(function(response) {
        $scope.currentUser = response.data;
        $http.get("/api/songs/?user_id=" + $scope.currentUser.id + ".json").then(function(response) {
          $scope.songs = response.data;
          $scope.songCount = $scope.songs.song_array.length;
        });
      });
    };

    $scope.sortBy = function(style) {
      if (style === 'all') {
        $scope.sortStyle = undefined;
      } else {
        $scope.sortStyle = String(style);
      }
    };

    $scope.playSong = function(inputSong) {
      var title = inputSong.title;
      $http.get("https://api.spotify.com/v1/search?query=" + title + "&type=track&limit=1").then(function(response) {
        $scope.previewUrl = $sce.trustAsResourceUrl(response.data["tracks"]["items"][0]["preview_url"]);
        $scope.albumImage = $sce.trustAsResourceUrl(response.data["tracks"]["items"][0]["album"]["images"][0]["url"]);
      });
      $scope.currentTitle = inputSong.title;
      $scope.currentComposer = inputSong.composer;
      angular.element("#myModal").appendTo('body').modal('show');
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
        $scope.usersArray = response.data;
      });
    };

    $scope.showSongs = function(inputUser) {
      $scope.showUserSongs = true;
      $http.get("/api/songs/?user_id=" + inputUser.id + ".json").then(function(response) {
        $scope.userSongs = response.data;
        $scope.totalUserSongs = $scope.userSongs["song_array"].length;
      });
    };

    $scope.delete = function(songObject) {
      var songId = songObject.id;
      $http.get("api/remove_song/" + songId).then(function(response) {
        console.log(response);
      });
      var songIndex = $scope.songs.song_array.indexOf(songObject);
      $scope.songs.song_array.splice(songIndex, 1);
    };

    window.$scope = $scope;
  });
})();
