class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  delegate :email, to: :user, prefix: true #-> creates comment.user.email
end
