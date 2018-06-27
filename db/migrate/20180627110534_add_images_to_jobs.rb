class AddImagesToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :images, :string
  end
end
