module SongsHelper

  def strip_title(filename)
    # locate file type extension at end of name
    last_dot = filename.rindex('.') || filename.length - 1
    # remove file extension and begining numbers to take care of files stored with preceding track number
    filename_no_tag = filename[0...last_dot] 
    @title = /[^\d\s].+/.match("#{filename_no_tag}")[0]
  end
end

