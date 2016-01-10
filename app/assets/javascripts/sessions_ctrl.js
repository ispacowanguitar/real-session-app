/* global angular */

(function() {
  "use strict";
  angular.module("app").controller("sessionsCtrl", function($scope, $http) {
    $scope.setup = function(sessionId) {
      $http.get("/api/session_users/" + sessionId).then(function(usersResponse) {
        $scope.users = usersResponse.data;
        $scope.songs = [];
        for (var i = 0; i < $scope.users.length; i++) {
          $http.get("/api/songs/?user_id=" + $scope.users[i].id).then(function(songsResponse) {
            // for (var i = 0; i < songsResponse.data.song_array.length; i ++) {
            //   songsResponse.data.song_array[i].is_in_common = false;
            //   // console.log(songsResponse.data.song_array[i]);
            // }
            $scope.songs.push(songsResponse.data);
          });
        }
      });
    };

    $scope.showIndividualSongs = function() {
      $scope.showIndividual = !$scope.showIndividual;
    };

    $scope.showCommonSongs = function() {

      var arrays = $scope.songs.map(songsObject => songsObject.song_array.map(song => song.title));
      console.log(arrays);
      var commonSongTitles = arrays.shift().filter(function(v) {
        return arrays.every(function(a) {
          return a.indexOf(v) !== -1;
        });
      });
      console.log(commonSongTitles);

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
      $scope.firstUserSongs = $scope.songs[0].song_array;
      $scope.showCommon = !$scope.showCommon;
    };

    window.$scope = $scope;
  });
})();

