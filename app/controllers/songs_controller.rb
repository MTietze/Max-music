class SongsController < ApplicationController
  include SongsHelper
  helper_method :sort_column, :sort_direction
  

  def index
  	@songs = Song.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 15, :page => params[:page])
  end

  def create
    @song = Song.new(song_params)
    @song.save
  end

  #update db with any new songs that were uploaded directly to amazon
  def update 
    s3 = AWS::S3.new
    amazons = s3.buckets[BUCKET].objects
    Song.destroy_all
    amazons.each do |song|
      strip_title(song.key)
      Song.create(title: @title, filename: song.key, year: song.metadata["year"], artist: song.metadata["artist"], blurb: song.metadata["blurb"])
    end
    redirect_to songs_path 
  end

  def upload
    s3 = AWS::S3.new
    filename = params[:musicfile].original_filename
    strip_title(filename)
    obj = s3.buckets[BUCKET].objects[filename]
    obj.write(params[:musicfile].read, acl: :public_read, content_disposition: "attachment")
    Song.create(title: @title, filename: filename)
    redirect_to songs_path  
  end

  private  
  
  def sort_column
    Song.column_names.include?(params[:sort]) ? params[:sort] : "year"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end

