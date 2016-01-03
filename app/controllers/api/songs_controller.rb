class Api::SongsController < ApplicationController
  def get_songs
    render :json => Song.all
  end

  def get_styles
      style_group = Song.sort_by_style(Song.all)[params[:style]]
      render :json => style_group
  end
end
