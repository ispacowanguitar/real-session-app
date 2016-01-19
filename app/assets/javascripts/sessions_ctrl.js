/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("sessionsCtrl", function($scope, $http, $sce) {
    $scope.setup = function(sessionId) {
      $http.get("/api/session_users/" + sessionId).then(function(usersResponse) {
        $scope.users = usersResponse.data;
        $scope.songs = [];
        for (var i = 0; i < $scope.users.length; i++) {
          $http.get("/api/songs/?user_id=" + $scope.users[i].id).then(function(songsResponse) {
            $scope.songs.push(songsResponse.data);
          });
        }
      });
    };

    $scope.showRandomCommonSong = function() {
      $scope.showCommonSongs();
      $scope.showCommon = false;
      $scope.commonSongsArray = [];
      for (var i = 0; i < $scope.firstUserSongs.length; i++) {
        if ($scope.firstUserSongs[i].isInCommon) {
          $scope.commonSongsArray.push($scope.firstUserSongs[i]);
        }
      }
      $scope.randomSong = $scope.commonSongsArray[Math.floor(Math.random() * $scope.commonSongsArray.length)];
      $scope.randSongComposer = $scope.randomSong.composer.replace(/([A-Z])/g, ' $1').trim();
      $scope.randSongShow = true;
    };

    $scope.showIndividualSongs = function() {
      $scope.showCommonSongs();
      $scope.showIndividual = !$scope.showIndividual;
      $scope.showCommon = false;
      $scope.randSongShow = false;
    };

    $scope.isCommon = function(object) {
      if (object.isInCommon) {
        return true;
      } else {
        return false;
      }
    };

    $scope.isNotCommon = function(object) {
      if (object.isInCommon) {
        return false;
      } else {
        return true;
      }
    };

    $scope.sortBy = function(style) {
      console.log(style);
      if (style === 'all') {
        $scope.sortStyle = undefined;
      } else {
        $scope.sortStyle = String(style);
      }
    };

    $scope.showCommonSongs = function() {

      var arrays = $scope.songs.map(songsObject => songsObject.song_array.map(song => song.title));
      var commonSongTitles = arrays.shift().filter(function(v) {
        return arrays.every(function(a) {
          return a.indexOf(v) !== -1;
        });
      });

      //loop through all songs and flag as either common or not common
      for (var j = 0; j < commonSongTitles.length; j++) {
        for (var userIndex = 0; userIndex < $scope.songs.length; userIndex++) {
          for (var i = 0; i < $scope.songs[userIndex].song_array.length; i++) {
            if ($scope.songs[userIndex].song_array[i].isInCommon !== true) {
              $scope.songs[userIndex].song_array[i].isInCommon = false;
            }
            if (commonSongTitles[j] === $scope.songs[userIndex].song_array[i].title) {
              $scope.songs[userIndex].song_array[i].isInCommon = true;
            }
          }
        }
      }
      $scope.commonSongsLength = commonSongTitles.length;
      $scope.firstUserSongs = $scope.songs[0].song_array;
      $scope.showCommon = !$scope.showCommon;
      $scope.showIndividual = false;
    };

    $scope.playSong = function(inputSong) {
      console.log(inputSong);
      var title = inputSong.title.split(" ").join("%20");
      $http.get("https://api.spotify.com/v1/search?query=" + title + "&type=track&limit=1").then(function(response) {
        $scope.previewUrl = $sce.trustAsResourceUrl(response.data["tracks"]["items"][0]["preview_url"]);
        $scope.albumImage = $sce.trustAsResourceUrl(response.data["tracks"]["items"][0]["album"]["images"][0]["url"]);
      });
      $scope.currentTitle = inputSong.title;
      $scope.currentComposer = inputSong.composer;
      $("#myModal").modal('show');
    };

    document.getElementById('audioClose').onclick = function() {
      var sounds = document.getElementsByTagName('audio');
      for (var i = 0; i < sounds.length; i++) {
        sounds[i].pause();
        console.log("audio close function");
      }
    };

    window.$scope = $scope;
  });
})();

