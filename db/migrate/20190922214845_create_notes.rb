class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :content
      t.integer :note_subject_id
      t.string :note_subject_type

      t.timestamps
    end
  end
end
