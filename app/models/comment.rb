class Comment < ApplicationRecord
  validates_presence_of :comment

  belongs_to :project
  belongs_to :user
end
