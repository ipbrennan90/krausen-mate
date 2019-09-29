class Note < ApplicationRecord
  has_many :children, :class_name => "Note", foreign_key: 'parent_id'
  belongs_to :parent, :class_name => "Note", foreign_key: 'parent_id', optional: true

  belongs_to :note_subject, polymorphic: true

end