# frozen_string_literal: true
class Category < ActiveRecord::Base
  has_many :forums

  validates :title, presence: true
end
