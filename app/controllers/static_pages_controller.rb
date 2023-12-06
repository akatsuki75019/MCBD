class StaticPagesController < ApplicationController
  def index
    @books = Book.all
    @events = Event.all
  end

  def contact
  end
end