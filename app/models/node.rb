class Node < ApplicationRecord
  has_closure_tree
  validates :content, presence: true, length: { maximum: 255}
end
