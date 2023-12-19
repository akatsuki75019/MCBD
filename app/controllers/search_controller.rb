class SearchController < ApplicationController
  def show
    @query = params[:query]
    @books = Book.search_book(@query) if @query.present?
    @events = Event.search_event(@query) if @query.present?
  end
end