app = angular.module("Songs", [])
app.directive "jplayer", ->
  restrict: "EA"
  template: "<div></div>"
  link: (scope, element, attrs) ->
    $control = element
    $player = $control.children("div")
    cls = "pause"
    updatePlayer = ->
      
      # Flash fallback for outdated browser not supporting HTML5 audio/video tags
      # http://jplayer.org/download/
      $player.jPlayer(
        swfPath: "/assets/jQuery.jPlayer.2.5.0"
        supplied: "m4a"
        solution: "html, flash"
        preload: "auto"
        wmode: "window"
        ready: ->
          $player.jPlayer "setMedia",
            mp4: '#'
          return
        play: ->
          $control.addClass cls
          $player.jPlayer "pauseOthers"  if attrs.pauseothers is "true"
          return
        pause: ->
          $control.removeClass cls
          return
        stop: ->
          $control.removeClass cls
          return
        ended: ->
          $control.removeClass cls
          return
      ).end().unbind("click").click (e) ->
        $player.jPlayer (if $control.hasClass(cls) then "stop" else "play")
        return
      return
    scope.$watch attrs.audio, updatePlayer
    updatePlayer()
    return


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

