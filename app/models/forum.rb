# frozen_string_literal: true
class Forum < ActiveRecord::Base
  belongs_to :forum
  has_many :forums

  validates :description, presence: true
end
