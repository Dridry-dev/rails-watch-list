class BookmarksController < ApplicationController
  # def new
  #   @bookmark = Bookmark.new
  # end

  # def create
  #   @list = List.find(params[:list_id])
  #   @bookmark = Bookmark.new(bookmark_params)
  #   @bookmark.list = @list
  #   if @bookmark.save
  #     redirect_to list_path(@bookmark.list)
  #   else
  #     @bookmarks = @list.bookmarks
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @movies = Movie.where(id: params.dig(:bookmark, :movie))
    if @movies.empty?
      return render_new
    end
    ActiveRecord::Base.transaction do
      @movies.each do |movie|
        bookmark = Bookmark.new(list: @list, movie: movie)
        bookmark.save!
      end
      redirect_to list_path(@bookmark.list)
    end
  rescue ActiveRecord::RecordInvalid
    render_new
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end

  def render_new
    @bookmark = Bookmark.new
    @bookmark.errors.add(:base, "A selected already exists")
    render :new, status: :unprocessable_entity
  end

  # def create
  #   @movie = Movie.find(params [:movie_id])
  #   @bookmark = Bookmark.new(movie: @movie)


  #   # @list = List.find(params[:id])
  #   # @bookmark = Bookmark.new(bookmark_params)
  #   if @bookmark.save
  #     redirect_to bookmark_path(@bookmark)
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @bookmark = Bookmark.find(params[:id])
  #   @bookmark.destroy
  #   redirect_to lists_path(@list)
  # end

  # private

  # def bookmark_params
  #   params.require(:bookmark).permit(:comment)
  # end
end
