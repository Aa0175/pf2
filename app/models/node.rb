class Node < ApplicationRecord
  has_closure_tree
  # belongs_to :post
  validates :content, presence: true, length: { maximum: 255}
end
