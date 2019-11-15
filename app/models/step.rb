class Step < ApplicationRecord
  has_many :children, :class_name => "Step", foreign_key: 'parent_id'
  belongs_to :parent, :class_name => "Step", foreign_key: 'parent_id', optional: true

  belongs_to :recipe
end