class BookmarksController < ApplicationController
  before_action :set_list
  before_action :set_bookmark, only: [:destroy, :new, :create]

  def new
    @bookmark = @list.bookmarks.build
  end

  def create
    @bookmark = @list.bookmarks.build(bookmark_params)

    if @bookmark.save
      redirect_to @list, notice: 'Bookmark was successfully created.'
    else
      render_error_response
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to @list || root_path, notice: 'Bookmark was successfully destroyed.'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id]) if params[:id]
  end

  def set_list
    @list = List.find(params[:list_id]) if params[:list_id]
  end

  def render_error_response
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: { errors: @bookmark.errors.full_messages }, status: :unprocessable_entity }
    end
  end
end
