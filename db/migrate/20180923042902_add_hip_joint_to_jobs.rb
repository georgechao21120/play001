class AddHipJointToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :aaa, :text
    add_column :jobs, :bbb, :text
    add_column :jobs, :cartilage, :text
    add_column :jobs, :age, :text
  end
end
