class StaticPagesController < ApplicationController
  def index
    @books = Book.all
    @events = Event.all
  end

  def contact
  end

  def cgv
  end

  def rgpd
  end

  def mentions_legales
  end

end