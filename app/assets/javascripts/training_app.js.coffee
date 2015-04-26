quiz = angular.module("Quiz", ['ngSanitize', 'ui.router', 'templates'])

quiz.config ['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $locationProvider.html5Mode(true);

  $stateProvider
    .state '/',
      redirectTo: (current, path, search) ->
        if(search.goto)
          # // if we were passed in a search param, and it has a path
          # // to redirect to, then redirect to that path
          "/" + search.goto
        else
          # // else just redirect back to this location
          # // angular is smart enough to only do this once.
          "/"
              
    .state 'theory', 
      url: "/theory/:questionType"
      templateUrl: "theory_training.html"
      controller: 'TheoryCtrl'
    
    .state 'ear',
      url: "/ear/:questionType"
      templateUrl: "ear_training.html"
      controller: 'EarCtrl'

  $urlRouterProvider.otherwise('/ear/intervals');

]

quiz.run ['$rootScope', '$stateParams', '$state', '$location', ($rootScope, $stateParams, $state, $location) ->
  $rootScope.$stateParams = $stateParams
  $rootScope.$state = $state
  MIDI.loader = new widgets.Loader
  MIDI.loadPlugin
    soundfontUrl: "sound/"
    instrument: "acoustic_grand_piano"
    callback: -> 
      MIDI.loader.stop() 
      velocity = 127
      MIDI.programChange(0, 0)
]

