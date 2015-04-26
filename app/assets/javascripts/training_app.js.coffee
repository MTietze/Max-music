quiz = angular.module("Quiz", ['ngSanitize', 'ui.router', 'templates'])

quiz.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->

  $stateProvider
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

