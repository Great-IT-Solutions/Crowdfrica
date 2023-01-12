class Comment < ApplicationRecord
  # Associations
  belongs_to :commenter, polymorphic: true
  belongs_to :commentable, polymorphic: true
end
