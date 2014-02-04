@.Training ?= {}    # create Training if it doesn't exist already
@.Training.checkInterval = (interval)->
  switch (interval)
      when 0
        x = 'Perfect unison'
      when 1
        x = 'Minor second'
      when 2
        x = 'Major second'
      when 3
        x = 'Minor third'
      when 4
        x = 'Major third'
      when 5
        x = 'Perfect fourth'
      when 6
        x = 'Diminished fifth'
      when 7
        x = 'Perfect fifth'
      when 8
        x = 'Minor sixth'
      when 9
        x = 'Major sixth'
      when 10
        x = 'Minor seventh'
      when 11
        x = 'Major seventh'
      when 12
        x = 'Perfect octave'

  return x
  
$(document).on "click", '#quiz', ->
  $('#quizbody').removeClass('hidden')