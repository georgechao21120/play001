class AddMoreDetailmacToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :opare, :text
    add_column :jobs, :read, :text
  end
end
