app = angular.module("Songs", [])
@SongsCtrl = ["$scope", "$http", ($scope, $http) ->
  $http.get("/show").success (data, status, headers, config) ->
   	$scope.songs = data
  $scope.download_url_for = (song_key) ->
    #hack to make mp3 files downloadable 
   "https://s3.amazonaws.com/Max-music/" + song_key.replace /\s/g, "+"


]
$ ->
  $(document).on "click", "#songs th a", ->
    $.getScript @href
    ga 'send', 'event', 'Songs', 'sort', $(this).text()
    false

  $(document).on 'submit', '#songs_search', ->
    $this = $(this)
    $.get @action, $this.serialize(), null, 'script'
    ga 'send', 'event', 'Songs', 'search'
    false

