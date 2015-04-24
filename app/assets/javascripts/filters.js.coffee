quiz = angular.module 'Quiz'

quiz.filter 'romanize', [(chord, root) ->
	if chord 
  	romanMap = 
  		0 : 8544 
  		1 : 8545
  		2 : 8545
  		3 : 8546
  		4 : 8546
  		5 : 8547
  		6 : 8548
  		7 : 8548
  		8 : 8549
  		9 : 8549
  		10 : 8550
  		11 : 8550 
	
  	# determine position of chord in the key by comparing its root to the root of key
  	chordPosition = chord.root - root
	
  	romanCode = romanMap[chordPosition]
	
  	if chord.quality is "minor" or chord.quality is "diminished" then romanCode+=16
  	romanCode = "&##{romanCode}"
  	#add flat symbol when appropriate
  	unless [1,3,6,8,10].indexOf chordPosition is -1 then romanCode = "&#9837#{romanCode}"
  	
  	if chord.quality is "diminished" then romanCode += "&deg" #degree symbol
	
  	romanCode
]