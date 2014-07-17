module SongsHelper

  def download_url_for(song_key)
    #hack to make mp3 files downloadable 
    song_key.gsub!(" ", "+") 
  	"https://s3.amazonaws.com/#{BUCKET}/#{song_key}" 
  end

  def strip_title(filename)
    # locate file type extension at end of name
    last_dot = filename.rindex('.') || filename.length - 1
    # remove file extension and begining numbers to take care of files stored with preceding track number
    filename_no_tag = filename[0...last_dot] 
    @title = /[^\d\s].+/.match("#{filename_no_tag}")[0]
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction)
  end
end

  def add_icon(column)
    if  column == sort_column
      if column == 'year' 
        if sort_direction === 'asc'
          "glyphicon glyphicon-arrow-up"
        else 
          "glyphicon glyphicon-arrow-down"
        end
      else
        if sort_direction === 'asc'
          "glyphicon glyphicon-arrow-down"
        else 
          "glyphicon glyphicon-arrow-up"
        end 
      end 
    else
      ""
    end
  end

