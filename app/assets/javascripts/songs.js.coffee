app = angular.module("Songs", [])

@SongsCtrl = ["$scope", "$http", ($scope, $http) ->
  $http.get("/show").success (data, status, headers, config) ->
   	$scope.songs = data
  $scope.download_url_for = (song_key) ->
    #hack to make mp3 files downloadable 
   "https://s3.amazonaws.com/Max-music/" + song_key.replace /\s/g, "+"
  $scope.order = 'year'
  $scope.reverse = true 
  $scope.setOrder = (column)->
  	if $scope.order == column
  	  $scope.reverse = !$scope.reverse
  	else
  		$scope.order = column 
  		$scope.reverse = if column == 'year' then true else false 
  $scope.arrow = (column)->
  	if $scope.order == column
  		if column == 'year' #make year have down arrow for descending years
        if $scope.reverse then "glyphicon glyphicon-arrow-down" else "glyphicon glyphicon-arrow-up"
      else
      	if !$scope.reverse then "glyphicon glyphicon-arrow-down" else "glyphicon glyphicon-arrow-up"
  	else
  		""
  $scope.currentSong = undefined
  $scope.setCurrentSong = (song) ->
     $scope.currentSong = song
  # $scope.play = (song)->
  #   $scope.currentSong = song
  #   play(download_url_for song)

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

