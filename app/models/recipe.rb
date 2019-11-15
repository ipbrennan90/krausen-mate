class Recipe < ApplicationRecord
  has_many :children, :class_name => "Recipe", foreign_key: 'parent_id'
  belongs_to :parent, :class_name => "Recipe", foreign_key: 'parent_id', optional: true
  belongs_to :user

  has_many :notes, as: :note_subject, dependent: :destroy
  has_many :ingredients
  has_many :steps
end
