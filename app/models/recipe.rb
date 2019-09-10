class Recipe < ApplicationRecord
  has_many :children, :class_name => "Recipe", foreign_key: 'parent_id'
  belongs_to :parent, :class_name => "Recipe", foreign_key: 'parent_id', optional: true

  belongs_to :user
end
