class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :qualification
      t.references :course, index: true

      t.timestamps
    end
  end
end
