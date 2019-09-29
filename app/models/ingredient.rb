class Ingredient < ApplicationRecord
  validates :name, :amount, :unit, presence: true
  has_many :children, :class_name => "Ingredient", foreign_key: 'parent_id'
  belongs_to :parent, :class_name => "Ingredient", foreign_key: 'parent_id', optional: true

  belongs_to :recipe

  has_many :notes, as: :note_subject, dependent: :destroy
end
