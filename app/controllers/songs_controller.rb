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
    amazons.each do |song|
      strip_title(song.key)
      unless Song.find_by(title: @title)
        Song.create(title: @title, filename: song.key, year: song.metadata["x-amz-meta-year"], artist: song.metadata["x-amz-meta-artist"])
      end
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

  # def destroy
  # 	if (params[:song])  
  #     Song.find_by(filename: params[:song]).delete  
  #     AWS::S3::S3Object.find(params[:song], BUCKET).delete
  #     redirect_to songs_path  
  #   else  
  #     render :text => "No song was found to delete!"  
  #   end 
  # end


  private  
  
  def sort_column
    Song.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end