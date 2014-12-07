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
]

quiz.run ['$rootScope', '$stateParams', '$state', '$location', ($rootScope, $stateParams, $state, $location) ->
  $state.transitionTo('ear', {questionType: 'intervals'})
  $rootScope.$stateParams = $stateParams
  $rootScope.$state = $state
]

