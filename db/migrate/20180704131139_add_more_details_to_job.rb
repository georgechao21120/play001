class AddMoreDetailsToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :num, :text
    add_column :jobs, :paper, :text
    add_column :jobs, :person, :text
    add_column :jobs, :hct, :text
    add_column :jobs, :apple, :text
    add_column :jobs, :ori, :text
  end
end
