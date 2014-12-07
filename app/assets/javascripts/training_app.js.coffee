quiz = angular.module("Quiz", ['ngSanitize', 'ui.router'])

quiz.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'theory', 
      url: "/theory/:questionType"
      template: "training.html.erb"
      controller: 'TheoryCtrl'
    
    .state 'ear',
      url: "/ear/:questionType"
      template: "training.html.erb"
      controller: 'EarCtrl'
]

quiz.run ['$rootScope', '$stateParams', '$state', '$location', ($rootScope, $stateParams, $state, $location) ->
  $state.transitionTo('ear', {questionType: 'intervals'})
  $rootScope.$stateParams = $stateParams
  $rootScope.$state = $state
]
