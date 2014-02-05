$(document).on 'ready page:change', ->
  chromatic_scale = undefined
  current_scale = undefined
  current_degree = undefined 
  current_scale_root = undefined
  current_note = undefined
  current_position = undefined
  key_number = undefined
  scale_type = undefined
 
  createScale = ->
    #clear previous evaluated answer
    $('#evaluation').html("")
    #keys divided by sharps or flats, Gb/F# doubling is reason for numbering
    keys = [[0,'natural'],[1,'flat'],[2,'sharp'],[3,'flat'],[4,'sharp'],[5,'flat'],
    [6,'sharp'],[6,'flat'],[7,'sharp'],[8,'flat'],[9,'sharp'],[10,'flat'],[11,'sharp']]
    
    chromatic_accidental =   
      'sharp': ['C', 'C#', 'D', 'D#', 'E', 'E#', 'F#', 'G', 'G#', 'A', 'A#', 'B']
      'flat': ['C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab', 'A', 'Bb', 'Cb']
      'natural': ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    #type of scale and pattern of notes in it
    formula = ["Major", [0,2,4,5,7,9,11]]
    if $("#minorScale").prop("checked")
      formula = ["Minor", [9,11,0,2,4,5,7]]
    scale_type = formula[0]
    #choose current key at random
    key = keys[Math.floor(Math.random()*13)]
    key_number = key[0]
    accidental_type = key[1]
    #determine if sharp or flat key
    chromatic_scale = chromatic_accidental[accidental_type]
    #set scale formula at right position in chromatic scale 
    adjusted_scale_formula = (note += key_number for note in formula[1])
    #match degrees to note names, modulo is so that it will cycle through the scale
    current_scale = [
      ['root', chromatic_scale[adjusted_scale_formula[0] % 12], 'Major'],
      ['second', chromatic_scale[adjusted_scale_formula[1] % 12], 'Minor'],
      ['third', chromatic_scale[adjusted_scale_formula[2] % 12], 'Minor'],
      ['fourth', chromatic_scale[adjusted_scale_formula[3] % 12], 'Major'],
      ['fifth', chromatic_scale[adjusted_scale_formula[4] % 12], 'Major'],
      ['sixth', chromatic_scale[adjusted_scale_formula[5] % 12], 'Minor'],
      ['seventh', chromatic_scale[adjusted_scale_formula[6] % 12], 'Diminished']]
    
    current_scale_root = current_scale[0][1]    
    current_position = Math.floor(Math.random()*6) + 1
    current_degree = current_scale[current_position][0]
    current_note = current_scale[current_position][1]

  ScaleQuestion = ->
    createScale()
    $('#question').html("What is the #{current_degree} degree in the key of #{current_scale_root} #{scale_type}?")

  ChordQuestion = ->
    createScale()
    current_chord = [current_scale[current_position], current_scale[(current_position + 2) % 7], current_scale[(current_position + 4) % 7]]
    missing_note = Math.floor(Math.random()*2) + 1
    current_note = current_chord[missing_note][1]
    if missing_note is 1
      $('#question').html("Enter the missing note to complete the #{current_chord[0][1]} #{current_chord[0][2]} chord. <br>
      #{current_chord[0][1]} ___ #{current_chord[2][1]}")
    else
      $('#question').html("Enter the missing note to complete the #{current_chord[0][1]} #{current_chord[0][2]} chord. <br>
      #{current_chord[0][1]}  #{current_chord[1][1]} ___")
  
  IntervalQuestion = ->
    createScale()
    first_note_position = Math.floor(Math.random()*12)
    second_note_position = Math.floor(Math.random()*12)
    interval = second_note_position - first_note_position #swap position for descending
    first_note = chromatic_scale[first_note_position]
    second_note = chromatic_scale[second_note_position]
    if interval <= 0
      interval += 12
    current_note = Training.checkInterval(interval)
    intervals = ['Minor second','Major second','Minor third','Major third','Perfect fourth','Diminished fifth','Perfect fifth','Minor sixth','Major sixth','Minor seventh','Major seventh','Perfect octave']
    
    $('#question').html(" What is the name of the <div class='btn-group'>
    <div class='btn-group dropup'><button type='button' id= 'intervaldrop' class='btn btn-default dropdown-toggle' data-toggle='dropdown'>
    Interval<span class='caret'></span></button><ul class='dropdown-menu' id='interval_list'></ul></div></div> ascending from #{first_note} to #{second_note}?")

    $('#interval_list').append("<li><a href='#' class= 'interval_choice'>#{interval_name}</a></li>") for interval_name in intervals 
  
  evaluateAnswer = ->
    answer = $('#answer').val().trim().toLowerCase()
    if answer is current_note.toLowerCase() 
      $('#evaluation').html('<p>Correct!</p>')
      return true
    else 
      $('#evaluation').html('<p id="sorry"> Sorry, try again </p>')
      return false
  

  $(document).on 'click', '.interval_choice', ->
    $('#answer').val($(this).text()) 
    
    if evaluateAnswer()
      $('#intervaldrop').trigger('click')
  
  $(document).on 'click', '#quiz.theory-quiz', ->
    $('#answer').val('')
    $('#quizform').removeClass('hidden')
    quiz_type = $('.currentQuiz').text()[0...-1]
    eval(quiz_type + 'Question()')
    

  $(document).on 'click', '#submitanswer', ->
    evaluateAnswer()
	
  # prevent clicking enter on text box from refreshing page
  $('#quizform').submit (e) -> 
    e.preventDefault()
    evaluateAnswer()
  
  $(document).on 'click', '#typeQuiz > button, #typeTraining > button', ->
    group = $(this).parent().attr('id')[4...]
    $(this).siblings().removeClass("current#{group}")
    $(this).addClass("current#{group}")
  
  $(document).on 'click', '#typeTraining > button', ->
    training_type = $(this).attr('id')[0...-8] 
    $('#question').html('')
    $('#evaluation').html('')
    if training_type is 'theory'    
      other_training = 'ear'
      $('#hearAgain').remove()
      $('#checkcolumn').css('visibility', 'hidden')
    else  
      other_training = 'theory'
      $('#quizform').addClass('hidden')
      $('#checkcolumn').css('visibility', 'visible')
    $('.quiz').removeClass("#{other_training}-quiz")
    $('.quiz').addClass("#{training_type}-quiz")