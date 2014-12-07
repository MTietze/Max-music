quiz = angular.module('Quiz')

quiz.controller 'EarCtrl', ["$scope",'$stateParams', '$state', '$location', '$timeout', ($scope, $stateParams, $state, $location, $timeout) ->
  
  $scope.quiz_type = undefined
  $scope.root = undefined
  $scope.all = undefined
  $scope.current_interval = undefined
  $scope.scale_name = undefined
  $scope.cols = undefined
  $scope.chord1 = undefined
  $scope.chord2 =undefined
  $scope.notes= []
  $scope.scales = [{quality: 'Harmonic minor', formula: [0,2,3,5,7,8,11,12]},
                 {quality: 'Melodic minor', formula: [0,2,3,5,7,9,11,12]},
                 {quality:'Ionian', formula:[0,2,4,5,7,9,11,12]}, 
                 {quality:'Dorian', formula:[0,2,3,5,7,9,10,12]},
                 {quality: 'Phrygian' , formula:[0,1,3,5,7,8,10,12]},
                 {quality:'Lydian' , formula:[0,2,4,6,7,9,11,12]},
                 {quality:'Mixolydian' , formula:[0,2,4,5,7,9,10,12]},
                 {quality:'Aeolian' , formula:[0,2,3,5,7,8,10,12]},
                 {quality:'Locrian' , formula:[0,1,3,5,6,8,10,12]}]

  checkRandom = ->
    # if checked put in a random key between E 52 and Eb 63
    if $scope.randomKeys
      $scope.root = 52 + Math.floor(Math.random() * 11)
    else
      $scope.root = 60
    
  isFirstCol = (column)->
    #set column size based on how many there are
    if column is 'major'
    	return $scope.minor or $scope.other and not ($scope.minor and $scope.other)
    if column is 'other'
    	return $scope.minor and not $scope.major 

    # if cols is 2
    #   $question.children(":nth-child(2)").addClass "col-sm-4"
    #   $question.children(":first").addClass "col-sm-4 col-sm-offset-2"
    # else
    #   $('#question').children().attr('class', "col-sm-" + (12/cols))
  createScales = ->
    checkRandom()
    current_scale = $scope.scales[Math.floor($scope.scales.length * Math.random())]
    $scope.scale_name = current_scale.quality
    $scope.notes = (note += root for note in current_scale.formula)
    # $question.append "<div id= 'majorButtons'> </div>"
    $scope.cols = 1
    # isFirstCol()
    # createScaleButton scale for scale in scales
    
  # createScaleButton = (scale) ->
  #   button = "<button href='#' id= 'scale_#{scale.quality.replace(" ", "_")}'class= 'btn btn-large btn-primary choice'>#{scale.quality}</button>"
  #   $("#majorButtons").append button
  $scope.earQuiz = ->
    # $question.children().remove()
    # quiz_type = $('.currentQuiz').text()
    # eval("create" + $stateParams.questionType. + "()")
    createScales()
    # hearNotes()
    # unless $('#hearAgain').length 
    #   $('#play').append('<button type="button" id= "hearAgain" class= "btn btn-default btn-md">Hear again</button>')
    # options = checkOptions()
    # ga 'send', 'event', 'Ear Quiz', quiz_type, options
  $scope.quiz = (type) ->
    $scope[type + 'Quiz']()
]



# $(document).on 'ready page:change', ->
#   if $('#typeQuiz').length || $('#started_body').length
#     # MIDI.loader = new widgets.Loader
#     MIDI.loadPlugin
#       soundfontUrl: "sound/"
#       instrument: "acoustic_grand_piano"
#       callback: -> 
#         # MIDI.loader.stop() 
#         velocity = 127
#         MIDI.programChange(0, 0)
      
    
#     quiz_type = undefined
#     root = undefined
#     all = undefined
#     current_interval = undefined
#     scale_name = undefined
#     cols = undefined
#     chord1 = undefined
#     chord2 =undefined
#     notes= []
#     $question = $('#question')
#     $randomKeys = $('#randomKeys')
    
#     createScales = ->
#       checkRandom()
  
#       scales = [{quality: 'Harmonic minor', formula: [0,2,3,5,7,8,11,12]},
#                {quality: 'Melodic minor', formula: [0,2,3,5,7,9,11,12]},
#                {quality:'Ionian', formula:[0,2,4,5,7,9,11,12]}, 
#                {quality:'Dorian', formula:[0,2,3,5,7,9,10,12]},
#                {quality: 'Phrygian' , formula:[0,1,3,5,7,8,10,12]},
#                {quality:'Lydian' , formula:[0,2,4,6,7,9,11,12]},
#                {quality:'Mixolydian' , formula:[0,2,4,5,7,9,10,12]},
#                {quality:'Aeolian' , formula:[0,2,3,5,7,8,10,12]},
#                {quality:'Locrian' , formula:[0,1,3,5,6,8,10,12]}]      
#       current_scale = scales[Math.floor(scales.length * Math.random())]
#       scale_name = current_scale.quality
#       notes = (note += root for note in current_scale.formula)
#       $question.append "<div id= 'majorButtons'> </div>"
#       cols = 1
#       isFirstCol()
#       createScaleButton scale for scale in scales
  
#     createScaleButton = (scale) ->
#       button = "<button href='#' id= 'scale_#{scale.quality.replace(" ", "_")}'class= 'btn btn-large btn-primary choice'>#{scale.quality}</button>"
#       $("#majorButtons").append button
  
#     createChords = ->
#       scale = [0...19]
#       cols = 0
#       allchords= []
#       all = false
#       $major = $("#major")
#       $minor = $("#minor")
  
#       checkRandom()
#       #put scale in correct key
#       scale = (note += root for note in scale)
  
#       if $("#other").prop("checked")
#         allchords = createMajorChords [0...12], scale 
#         allchords = allchords.concat(createMinorChords [0...12], scale)
#         allchords.sort (a,b) -> 
#           a.degree - b.degree
#         cols = 2
#         all = true 
#         $question.append "<div id= 'majorButtons'> </div> <div id= 'minorButtons'> </div>"
#       else
        
#         if $major.prop("checked")
#           cols += 1
#           allchords = createMajorChords([0,5,7], scale).concat(createMinorChords([2,4,9], scale).concat(createDiminishedChords([11],scale)))
#           allchords.sort (a,b) -> 
#             a.degree - b.degree
#           $question.append "<div id= 'majorButtons'> </div>"
#         if $minor.prop("checked")
#           allchords = allchords.concat createMajorChords([3,8,10], scale).concat(createMinorChords([0,5,7,], scale).concat(createDiminishedChords([2],scale)))
#           allchords.sort (a,b) -> 
#             a.degree - b.degree
#           cols += 1
#           $question.append "<div id= 'minorButtons'> </div>"
#         if $major.prop("checked") and $minor.prop("checked")
#           all = true
#           $question.append('<div id="otherChordButtons" class="col-sm-12"></div>') 
  
#       isFirstCol()
#       #randomly decide between major and minor scale
#       whichscale = Math.floor(cols * Math.random())
#       #set chord1 to to the root of the selected scale
#       chord1 = allchords[whichscale]  
#       chord2 = allchords[Math.floor(allchords.length * Math.random())]
#       notes = [[chord1.root, chord1.third, chord1.fifth], [chord2.root, chord2.third, chord2.fifth]]
#       createChordButton allchords[whichscale], c for c in allchords 
        
  
#     createChordButton = (rootchord, chord) ->
#       #create buffer for even spacing of roman numerals
#       if $.inArray(chord.degree, [1,3,6,8,10]) is -1 then buffer = "" else buffer = "&nbsp&nbsp"
#       if chord.quality is "diminished" then buffer = "&nbsp"
  
#       button = "<button href='#' id= 'chord_#{chord.degree}_#{chord.quality}'class= 'btn btn-large btn-primary choice'>#{buffer}#{romanize(rootchord)} - #{romanize(chord)}</button>"
#       #when displaying all chords, split columns based on second chord's quality rather than the root's
#       if all then rootchord = chord
  
#       if rootchord.quality is "major"
#         $("#majorButtons").append button
#       else if rootchord.quality is "minor"
#         $("#minorButtons").append button
#       else
#         $("#otherChordButtons").append button
  
      
#     createMajorChords = (degrees, scale) -> 
#         chords = []
#         for degree in degrees
#           chord = 
#             degree: scale[degree] - root 
#             root: scale[degree]
#             third: scale[degree+4]
#             fifth: scale[degree+7] 
#             quality: "major"
#           chords.push(chord)
#         return chords
  
  
#     createMinorChords = (degrees, scale) -> 
#       chords = []
#       for degree in degrees
#         chord = 
#           degree: scale[degree] - root
#           root: scale[degree]
#           third: scale[degree+3]
#           fifth: scale[degree+7] 
#           quality: "minor"
#         chords.push(chord)
#       return chords
    
#     createDiminishedChords = (degrees, scale) -> 
#       chords = []
#       for degree in degrees
#         chord = 
#           degree: scale[degree] - root
#           root: scale[degree]
#           third: scale[degree+3]
#           fifth: scale[degree+6] 
#           quality: "diminished"
#         chords.push(chord)
#       return chords 
  
#     createIntervals = ->
#       scale = []
#       intervals = []
#       cols = 0
      
#       #check which interval checkboxes are checked, add those intervals and account for columns
#       if $("#major").prop("checked")
#         scale = scale.concat([2, 4, 9, 11])
#         intervals = intervals.concat(["Major second", "Major third", "Major sixth", "Major seventh"])
#         cols += 1
#         $question.append "<div id= 'majorButtons'> </div>"
#       if $("#minor").prop("checked")
#         scale = scale.concat([1, 3, 6, 8, 10])
#         intervals = intervals.concat(["Minor second", "Minor third", "Diminished fifth", "Minor sixth", "Minor seventh"])
#         cols += 1
#         $question.append "<div id= 'minorButtons'> </div>"
#       if $("#other").prop("checked")
#         scale = scale.concat([0, 5, 7, 12])
#         intervals = intervals.concat(["Perfect unison", "Perfect fourth", "Perfect fifth", "Perfect octave"])
#         cols += 1
#         $question.append "<div id= 'otherButtons'> </div>"
      
#       isFirstCol()
  
#       checkRandom()
      
#       #put scale into correct key
#       scale = (note += root for note in scale)
  
#       firstnote = root
#       secondnote = scale[Math.floor(scale.length * Math.random())]
#       notes = [firstnote, secondnote]
#       current_interval =  secondnote - firstnote
  
      
#       #create interval buttons of possible answers
#       createIntervalButton int for int in intervals
    
#     romanize = (chord) ->
#     #assemble html codes for roman numerals based on degree
#       switch chord.degree
#         when 0
#           x = 8544 
#         when 1
#           x = 8545
#         when 2
#           x = 8545
#         when 3
#           x = 8546
#         when 4
#           x = 8546
#         when 5
#           x = 8547
#         when 6
#           x = 8548
#         when 7
#           x = 8548
#         when 8
#           x = 8549
#         when 9
#           x = 8549
#         when 10
#           x = 8550
#         when 11
#           x = 8550 
#       #lower cased roman numerals are 16 higher
#       if chord.quality is "minor" or chord.quality is "diminished" then x+=16
#       x = "&##{x}"
#       #add flat symbol when appropriate
#       unless $.inArray(chord.degree, [1,3,6,8,10]) is -1 then x = "&#9837#{x}"
#       if chord.quality is "diminished" then x += "&deg" #degree symbol
#       return x
    
#     checkRandom = ->
#       # if checked put in a random key between E 52 and Eb 63
#       if $randomKeys.prop("checked")
#         root = 52 + Math.floor(Math.random() * 11)
#       else
#         root = 60
  
#     isFirstCol = ->
#       #set column size based on how many there are
#       if cols is 2
#         $question.children(":nth-child(2)").addClass "col-sm-4"
#         $question.children(":first").addClass "col-sm-4 col-sm-offset-2"
#       else
#         $('#question').children().attr('class', "col-sm-" + (12/cols))
    
#     createIntervalButton = (interval) ->
#       button = "<a href='#' id= 'interval_" + interval.replace(" ", "_") + "'class= 'btn btn-large btn-primary choice'>" + interval + "</a>"
#       if /Major/.test(interval)
#         $("#majorButtons").append button
#       else if /Minor|Diminished/.test(interval)
#         $("#minorButtons").append button
#       else
#         $("#otherButtons").append button  
      
#     playNotes = (notes)->
#       playNote = (note, seconds) -> 
#         MIDI.noteOn 0, note, 127, seconds
#         MIDI.noteOff 0, note, seconds + 1
#       i = 0
#       while i < notes.length
#         playNote notes[i], i
#         i++
    
#     playChords = (chords) ->   
#       #written this way to give some functionality in non-chrome browsers
#       #other versions of code resulted in firefox playing one note for the 
#       # second chord, or chrome cutting the 2nd chord short on first play
#       MIDI.chordOn 0, chords[0], 127, 0
#       MIDI.chordOff 0, chords[0], 1
#       setTimeout -> 
#         MIDI.chordOn 0, chords[1], 127
#       , 1000
#       setTimeout -> 
#         MIDI.chordOff 0, chords[1]
#       , 2000
    
#     hearNotes = -> 
#       if quiz_type is "Chords"
#         playChords(notes)
#       else if $("#major").prop("checked") || $("#minor").prop("checked") || $("#other").prop("checked") || quiz_type is "Scales"
#         playNotes(notes)  

#     checkOptions = ->
#       options = ""
#       boxes = ['randomKeys', 'major', 'minor', 'other']
#       options += "#{box} " for box in boxes when $("##{box}").prop('checked')
#       return options[0..-2] #omit space at end
   
#     $(document).on "click", '#hearAgain', ->
#       hearNotes()
#       ga 'send', 'event', 'Ear Quiz', 'hear again', quiz_type

#     $(document).on "click", '#typeQuiz button', ->
#       $this = $(this)
#       $checkcolumn = $('#checkcolumn')
#       $('#hearAgain').remove()
#       $('#quizbody').addClass('hidden')
#       $randomKeys.parent().siblings('label').remove()
#       if $this.text() is 'Chords'
#         $checkcolumn.append('<label><input type="checkbox" id= "major" checked> <p>Major scale</p></label>')
#         $checkcolumn.append('<label><input type="checkbox" id= "minor"><p> Minor scale</p></label>')
#         $checkcolumn.append('<label><input type="checkbox" id= "other"><p> All Chords</p></label>')
#       else if $this.text() is 'Intervals'
#         $checkcolumn.append('<label><input type="checkbox" id= "major" checked><p> Major intervals</p></label>')
#         $checkcolumn.append('<label><input type="checkbox" id= "minor"><p> Minor intervals</p></label>')
#         $checkcolumn.append('<label><input type="checkbox" id= "other"> <p>Perfect intervals</p></label>')
  
#     $(document).on "click", '#quiz.ear-quiz', ->
#       $question.children().remove()
#       quiz_type = $('.currentQuiz').text()
#       eval("create" + quiz_type + "()")
#       hearNotes()
#       unless $('#hearAgain').length 
#         $('#play').append('<button type="button" id= "hearAgain" class= "btn btn-default btn-md">Hear again</button>')
#       options = checkOptions()
#       ga 'send', 'event', 'Ear Quiz', quiz_type, options

#     $(document).on "click", "[id^=interval_].choice",  ->
#       $this = $(this)
#       interval = Training.checkInterval current_interval
#       choice = $this.attr("id")[9...].replace('_',' ')
#       #if correct clear interval buttons then display the correct one and check mark image
#       if choice is interval
#         $question.html($this.css("pointer-events", "none").toggleClass('btn-primary btn-success'))
#         ga 'send', 'event', 'Ear Quiz', 'chord', interval, 1
#       #if incorrect button becomes red and crossed out
#       else
#         $this.addClass('wrong')
#         ga 'send', 'event', 'Ear Quiz', 'interval', "#{interval} chose #{choice}", -1

#     $(document).on "click", "[id^=chord_]",  ->
#       $this = $(this)
#       if $this.attr("id") is "chord_#{chord2.degree}_#{chord2.quality}"
#         $question.html($(this).css("pointer-events", "none").toggleClass('btn-primary btn-success'))
#         ga 'send', 'event', 'Ear Quiz', 'chord', "#{chord1.quality} 1 to #{chord2.quality} #{chord2.degree - 1}", 1
#       else
#         $this.addClass('wrong')
#         ga 'send', 'event', 'Ear Quiz', 'chord', "#{chord1.quality} 1 to #{chord2.quality} #{chord2.degree - 1} chose #{$this.text()}", -1
    
#     $(document).on "click", "[id^=scale_]",  ->
#       $this = $(this)
#       if $this.attr("id") is "scale_#{scale_name.replace(' ','_')}"
#         $question.html($(this).css("pointer-events", "none").toggleClass('btn-primary btn-success'))
#         ga 'send', 'event', 'Ear Quiz', 'scale', scale_name, 1
#       else
#         $this.addClass('wrong')
#         ga 'send', 'event', 'Ear Quiz', 'scale', "#{scale_name} chose #{$this.text()}", -1

#     $(document).on "click", '#major_scale',  ->
#       playNotes [60,62,64,65,67,69,71,72]
#       ga 'send', 'event', 'Getting Started', 'click', 'major scale'
    
#     $(document).on "click", '#minor_scale',  ->
#       playNotes [57,59,60,62,64,65,67,69]
#       ga 'send', 'event', 'Getting Started', 'click', 'minor scale'
    
#     $(document).on "click", '#harmonic_scale',  ->
#       playNotes [57,59,60,62,64,65,68,69]
#       ga 'send', 'event', 'Getting Started', 'click', 'harmonic scale'

#     $(document).on "click", '#melodic_scale',  ->
#       playNotes [57,59,60,62,64,66,68,69]
#       ga 'send', 'event', 'Getting Started', 'click', 'melodic scale'

#     $(document).on "click", '#chromatic_scale',  ->
#       playNotes [57..69]
#       ga 'send', 'event', 'Getting Started', 'click', 'chromatic scale'

#     $(document).on "click", 'a[id$=_interval]',  ->
#       note = 60 + parseInt $(this).attr('id')
#       playNotes [60, note]
#       ga 'send', 'event', 'Getting Started', 'click', 'interval'

#     $(document).on "click", 'a[id$=_mode]',  ->
#       cmajor = [60,62,64,65,67,69,71,72,74,76,77,79,81,83]
#       note = parseInt $(this).attr('id')
#       playNotes cmajor[note..note+7]
#       ga 'send', 'event', 'Getting Started', 'click', 'modal scale'

#     $(document).on "click", 'a[id$=_chord]',  ->
#       cmajor = [60,62,64,65,67,69,71,72,74,76,77,79,81,83]
#       note = parseInt $(this).attr('id')
#       chord= [[cmajor[note], cmajor[note+2], cmajor[note+4]]]
#       playChords chord
#       ga 'send', 'event', 'Getting Started', 'click', 'chord'

#     $(document).on "click", "button, a.notes", (e)  ->
#       e.preventDefault()