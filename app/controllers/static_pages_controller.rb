class StaticPagesController < ApplicationController
  def index
    @books = Item.all
    @events = Event.all
  end

  def contact
  end
end