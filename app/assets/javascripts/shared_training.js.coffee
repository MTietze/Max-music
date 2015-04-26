quiz = angular.module("Quiz")

quiz.service "sharedFunctions", [() ->
  intervalMap = 
    0  : 'Perfect unison'
    1  : 'Minor second'
    2  : 'Major second'
    3  : 'Minor third'
    4  : 'Major third'
    5  : 'Perfect fourth'
    6  : 'Diminished fifth'
    7  : 'Perfect fifth'
    8  : 'Minor sixth'
    9  : 'Major sixth'
    10 : 'Minor seventh'
    11 : 'Major seventh'
    12 : 'Perfect octave' 
  new class shared
    checkInterval: (interval)->
      intervalMap[interval]
]

quiz.controller "TrainingCtrl",  ['$scope', '$state', '$stateParams', ($scope, $state, $stateParams) ->
  $scope.changeQuestionType = (type) ->
    $state.go($state.current, {questionType: type})
  $scope.changeTrainingType = (state) ->
    $state.go(state, {questionType: $stateParams.questionType})
]