quiz = angular.module("Quiz", ['ngSanitize', 'ui.router'])

quiz.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state('theory', {
      url: "/theory/:questionType",
      template: "training.html.erb"
    })
    .state('ear', {
      url: "/ear/:questionType",
      template: "training.html.erb"
    })
]

quiz.run ['$rootScope', '$stateParams', '$state', '$location', ($rootScope, $stateParams, $state, $location) ->
  $rootScope.$stateParams = $stateParams
  $rootScope.$state = $state
  $state.transitionTo('ear', {questionType: 'intervals'})
]

@TheoryCtrl = ["$scope",'$stateParams', '$state', '$location', '$timeout', ($scope, $stateParams, $state, $location, $timeout) ->
  $scope.chromatic_scale = undefined
  $scope.current_scale = undefined
  $scope.current_degree = undefined 
  $scope.current_scale_root = undefined
  $scope.current_note = undefined
  $scope.current_position = undefined
  $scope.key_number = undefined
  $scope.scale_type = undefined
  $scope.timeoutID = undefined
  $scope.quizBtnText = "Submit"
  $scope.quizBtnState = "primary"
  
  $scope.evaluation = null
  $scope.answer = ''
  $scope.question = ''
                                              
  $evaluation = $('#evaluation')
  $question = $('#question')
  $answer = $('#answer')
  $quizform = $('#quizform')
  $checkrow = $('#checkrow')
  $trainingrow = $('#trainingrow')
  $performance = $('#performance')
  
  $scope.$on '$locationChangeStart', (event, toState, toParams, fromState, fromParams) ->
    $timeout.cancel $scope.timeoutID
    $scope.question = ''
    $scope.evaluation = ''

  createScale = ->
    #clear previous evaluated answer
    $scope.evaluation = null
    #keys divided by sharps or flats, Gb/F# doubling is reason for numbering
    keys = [[0,'natural'],[1,'flat'],[2,'sharp'],[3,'flat'],[4,'sharp'],[5,'flat'],
    [6,'sharp'],[6,'flat'],[7,'sharp'],[8,'flat'],[9,'sharp'],[10,'flat'],[11,'sharp']]
    
    chromatic_accidental =   
      'sharp': ['C', 'C#', 'D', 'D#', 'E', 'E#', 'F#', 'G', 'G#', 'A', 'A#', 'B']
      'flat': ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'Cb']
      'natural': ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    #type of scale and pattern of notes in it
    formula = ["Major", [0,2,4,5,7,9,11]]
    # if $("#minorScale").prop("checked")
    #   formula = ["Minor", [9,11,0,2,4,5,7]]
    $scope.scale_type = formula[0]
    #choose current key at random
    key = keys[Math.floor(Math.random()*13)]
    $scope.key_number = key[0]
    accidental_type = key[1]
    #determine if sharp or flat key
    $scope.chromatic_scale = chromatic_accidental[accidental_type]
    #set scale formula at right position in chromatic scale 
    adjusted_scale_formula = (note += $scope.key_number for note in formula[1])
    #match degrees to note names, modulo is so that it will cycle through the scale
    $scope.current_scale = [
      ['root', $scope.chromatic_scale[adjusted_scale_formula[0] % 12], 'Major'],
      ['second', $scope.chromatic_scale[adjusted_scale_formula[1] % 12], 'Minor'],
      ['third', $scope.chromatic_scale[adjusted_scale_formula[2] % 12], 'Minor'],
      ['fourth', $scope.chromatic_scale[adjusted_scale_formula[3] % 12], 'Major'],
      ['fifth', $scope.chromatic_scale[adjusted_scale_formula[4] % 12], 'Major'],
      ['sixth', $scope.chromatic_scale[adjusted_scale_formula[5] % 12], 'Minor'],
      ['seventh', $scope.chromatic_scale[adjusted_scale_formula[6] % 12], 'Diminished']]
    
    $scope.current_scale_root = $scope.current_scale[0][1]    
    $scope.current_position = Math.floor(Math.random()*6) + 1
    $scope.current_degree = $scope.current_scale[$scope.current_position][0]
    $scope.current_note = $scope.current_scale[$scope.current_position][1]
  questions =   
    scales: ->
      createScale()
      article = if $scope.current_scale_root[0] == 'A' || $scope.current_scale_root[0] == 'E' || $scope.current_scale_root[0] == 'F' then "an" else "a" 
      $scope.question = "What is the #{$scope.current_degree} note in #{article} #{$scope.current_scale_root} #{$scope.scale_type} scale?"
    
    chords: ->
      createScale()
      $scope.current_chord = [$scope.current_scale[$scope.current_position], $scope.current_scale[($scope.current_position + 2) % 7], $scope.current_scale[($scope.current_position + 4) % 7]]
      missing_note = Math.floor(Math.random()*2) + 1
      $scope.current_note = $scope.current_chord[missing_note][1]
      if missing_note is 1
        $scope.question = "Enter the missing note to complete the #{$scope.current_chord[0][1]} #{$scope.current_chord[0][2]} chord. <br>
        #{$scope.current_chord[0][1]} ___ #{$scope.current_chord[2][1]}"
      else
        $scope.question = "Enter the missing note to complete the #{$scope.current_chord[0][1]} #{$scope.current_chord[0][2]} chord. <br>
        #{$scope.current_chord[0][1]}  #{$scope.current_chord[1][1]} ___"
    
    intervals: ->
      createScale()
      first_note_position = Math.floor(Math.random()*12)
      second_note_position = Math.floor(Math.random()*12)
      interval = second_note_position - first_note_position #swap position to implement descending 
      $scope.first_note = $scope.chromatic_scale[first_note_position]
      $scope.second_note = $scope.chromatic_scale[second_note_position]
      if interval <= 0
        interval += 12
      $scope.current_note = Training.checkInterval(interval)
      $scope.intervals = ['Minor second','Major second','Minor third','Major third','Perfect fourth','Diminished fifth','Perfect fifth','Minor sixth','Major sixth','Minor seventh','Major seventh','Perfect octave']
      
      $scope.question = "intervalQuestion"
  
  $scope.evaluateAnswer = ->
    answer = $scope.answer.trim().toLowerCase()
    if answer is $scope.current_note.toLowerCase() 
      $scope.evaluation = true
      $scope.quizBtnText = "Correct"
      $scope.quizBtnState = "success"
      ga 'send', 'event', 'Theory Quiz', "answer", answer, 1
      evaluate = ->
         if $scope.evaluation then $scope.quiz($state.current.name)
      $scope.timeoutID = $timeout evaluate, 2000
      return true
    else 
      $scope.evaluation = false
      ga 'send', 'event', 'Theory Quiz', 'answer', "#{$scope.current_note} chose #{$scope.answer}", -1
      return false

  $scope.selectInterval = (interval) -> 
    $scope.answer = interval
    $scope.evaluateAnswer()
  
  $scope.theoryQuiz = ->
    $timeout.cancel $scope.timeoutID
    $scope.answer = ''
    $scope.quizBtnText = "Submit"
    $scope.quizBtnState = "primary"
    $scope.evaluation = null; 
    questions[$stateParams.questionType]() 
    ga 'send', 'event', 'Theory Quiz', $state.current.name
  
  $scope.quiz = (type) ->
    if type is "theory"
      $scope.theoryQuiz()

  $scope.changeQuestionType = (type) ->
    $state.transitionTo($state.current, {questionType: type})

  $scope.changeTrainingType = (state) ->
    $state.transitionTo(state, {questionType: $stateParams.questionType})
  
  # prevent clicking enter on text box from refreshing page
  # $quizform.submit (e) -> 
  #   e.preventDefault()
  #   evaluateAnswer()
  
  # $(document).on 'click', '#typeQuiz > button, #typeTraining > button', ->
  #   clearTimeout $scope.timeoutID
  #   $this = $(this)
  #   group = $this.parent().attr('id')[4...]
  #   $this.siblings().removeClass("current#{group}")
  #   $this.addClass("current#{group}")
  
  # $(document).on 'click', '#typeTraining > button', ->
  #   $quiz = $('.quiz')
  #   training_type = $(this).attr('id')[0...-8] 
  #   $scope.question = ''
  #   $scope.evaluation = ''
  #   if training_type is 'theory'    
  #     other_training = 'ear'
  #     $('#hearAgain').remove()
  #     $checkrow.addClass('hidden')
  #     $performance.css('display', 'none')
  #   else  
  #     other_training = 'theory'
  #     $quizform.addClass('hidden')
  #     $checkrow.removeClass('hidden')
  #     $performance.css('display', 'inherit')
  #   $quiz.removeClass("#{other_training}-quiz")
  #   $quiz.addClass("#{training_type}-quiz") 

]
# $(document).on 'ready page:change', ->
#   if $('#typeQuiz').length 
    # chromatic_scale = undefined
    # current_scale = undefined
    # current_degree = undefined 
    # current_scale_root = undefined
    # current_note = undefined
    # current_position = undefined
    # key_number = undefined
    # scale_type = undefined
    # timeoutID = undefined
    # $evaluation = $('#evaluation')
    # $question = $('#question')
    # $answer = $('#answer')
    # $quizform = $('#quizform')
    # $checkrow = $('#checkrow')
    # $trainingrow = $('#trainingrow')
    # $performance = $('#performance')

    # createScale = ->
    #   #clear previous evaluated answer
    #   $evaluation.html("")
    #   #keys divided by sharps or flats, Gb/F# doubling is reason for numbering
    #   keys = [[0,'natural'],[1,'flat'],[2,'sharp'],[3,'flat'],[4,'sharp'],[5,'flat'],
    #   [6,'sharp'],[6,'flat'],[7,'sharp'],[8,'flat'],[9,'sharp'],[10,'flat'],[11,'sharp']]
      
    #   chromatic_accidental =   
    #     'sharp': ['C', 'C#', 'D', 'D#', 'E', 'E#', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    #     'flat': ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'Cb']
    #     'natural': ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    #   #type of scale and pattern of notes in it
    #   formula = ["Major", [0,2,4,5,7,9,11]]
    #   # if $("#minorScale").prop("checked")
    #   #   formula = ["Minor", [9,11,0,2,4,5,7]]
    #   scale_type = formula[0]
    #   #choose current key at random
    #   key = keys[Math.floor(Math.random()*13)]
    #   key_number = key[0]
    #   accidental_type = key[1]
    #   #determine if sharp or flat key
    #   chromatic_scale = chromatic_accidental[accidental_type]
    #   #set scale formula at right position in chromatic scale 
    #   adjusted_scale_formula = (note += key_number for note in formula[1])
    #   #match degrees to note names, modulo is so that it will cycle through the scale
    #   current_scale = [
    #     ['root', chromatic_scale[adjusted_scale_formula[0] % 12], 'Major'],
    #     ['second', chromatic_scale[adjusted_scale_formula[1] % 12], 'Minor'],
    #     ['third', chromatic_scale[adjusted_scale_formula[2] % 12], 'Minor'],
    #     ['fourth', chromatic_scale[adjusted_scale_formula[3] % 12], 'Major'],
    #     ['fifth', chromatic_scale[adjusted_scale_formula[4] % 12], 'Major'],
    #     ['sixth', chromatic_scale[adjusted_scale_formula[5] % 12], 'Minor'],
    #     ['seventh', chromatic_scale[adjusted_scale_formula[6] % 12], 'Diminished']]
      
    #   current_scale_root = current_scale[0][1]    
    #   current_position = Math.floor(Math.random()*6) + 1
    #   current_degree = current_scale[current_position][0]
    #   current_note = current_scale[current_position][1]

    # #first letter of these functions are capital to facilitate using eval plus quiz_type
    # ScaleQuestion = ->
    #   createScale()
    #   article = if current_scale_root[0] == 'A' || current_scale_root[0] == 'E' || current_scale_root[0] == 'F' then "an" else "a" 
    #   $question.html("What is the #{current_degree} note in #{article} #{current_scale_root} #{scale_type} scale?")
  
    # ChordQuestion = ->
    #   createScale()
    #   current_chord = [current_scale[current_position], current_scale[(current_position + 2) % 7], current_scale[(current_position + 4) % 7]]
    #   missing_note = Math.floor(Math.random()*2) + 1
    #   current_note = current_chord[missing_note][1]
    #   if missing_note is 1
    #     $question.html("Enter the missing note to complete the #{current_chord[0][1]} #{current_chord[0][2]} chord. <br>
    #     #{current_chord[0][1]} ___ #{current_chord[2][1]}")
    #   else
    #     $question.html("Enter the missing note to complete the #{current_chord[0][1]} #{current_chord[0][2]} chord. <br>
    #     #{current_chord[0][1]}  #{current_chord[1][1]} ___")
    
    # IntervalQuestion = ->
    #   createScale()
    #   first_note_position = Math.floor(Math.random()*12)
    #   second_note_position = Math.floor(Math.random()*12)
    #   interval = second_note_position - first_note_position #swap position to implement descending 
    #   first_note = chromatic_scale[first_note_position]
    #   second_note = chromatic_scale[second_note_position]
    #   if interval <= 0
    #     interval += 12
    #   current_note = Training.checkInterval(interval)
    #   intervals = ['Minor second','Major second','Minor third','Major third','Perfect fourth','Diminished fifth','Perfect fifth','Minor sixth','Major sixth','Minor seventh','Major seventh','Perfect octave']
      
    #   $question.html(" What is the name of the <div class='btn-group'>
    #   <div class='btn-group dropup'><button type='button' id= 'intervaldrop' class='btn btn-default dropdown-toggle' data-toggle='dropdown'>
    #   Interval<span class='caret'></span></button><ul class='dropdown-menu' id='interval_list'><li><div class='row'><ul class='list-unstyled col-xs-6'></ul><ul class='list-unstyled col-xs-6'></ul>
    #   </div></li></ul></div></div> 
    #   ascending from #{first_note} to #{second_note}?")
  
    #   $('#interval_list li .row ul:first').append("<li><a href='#' class= 'interval_choice'>#{interval_name}</a></li>") for interval_name in intervals[0..5] 
    #   $('#interval_list li .row ul:last').append("<li><a href='#' class= 'interval_choice'>#{interval_name}</a></li>") for interval_name in intervals[6..11] 
      
    # evaluateAnswer = ->
    #   answer = $answer.val().trim().toLowerCase()
    #   if answer is current_note.toLowerCase() 
    #     $evaluation.html('')
    #     $('#submitanswer').replaceWith('<button class="btn btn-sm btn-success" id="correctanswer">Correct</button>')
    #     ga 'send', 'event', 'Theory Quiz', "answer", answer, 1
    #     timeoutID = setTimeout -> 
    #       if $('#correctanswer') then $('#quiz.theory-quiz').trigger('click') 
    #     , 2000
    #     return true
    #   else 
    #     $evaluation.html('<p id="sorry"> Sorry, try again </p>')
    #     ga 'send', 'event', 'Theory Quiz', 'answer', "#{current_note} chose #{answer}", -1
    #     return false
    
   