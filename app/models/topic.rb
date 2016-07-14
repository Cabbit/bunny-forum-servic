# frozen_string_literal: true
class Topic < ActiveRecord::Base
  belongs_to :forum
  has_many :posts

  validates :title, presence: true
end
