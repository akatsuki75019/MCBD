class StaticPagesController < ApplicationController
  def index
    @books = Book.all
    @events = Event.all
  end

  def contact
  end

  def terms_and_conditions
  end

  def gdpr
  end

  def legal_notice
  end

end