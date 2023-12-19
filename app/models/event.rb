require 'pg_search'
class Event < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_event, against: [:title, :description]

  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances


end