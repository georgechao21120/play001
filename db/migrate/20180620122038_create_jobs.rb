class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :pos
      t.text :size
      t.text :echo
      t.text :comp
      t.text :form
      t.text :edge
      t.text :calc
      t.text :color
      t.text :spec
      t.text :elas
      t.text :spare
      t.text :symp
      t.text :sign
      t.text :bio
      t.text :path
      t.text :treat
      t.text :aut

      t.timestamps
    end
  end
end
