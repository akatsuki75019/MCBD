class SearchController < ApplicationController
  def show
    @query = params[:query]
    @results = Book.where('title LIKE ?', "%#{@query}%")
  end
end
