class AddMoreDetailtrToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :seltrdes, :text
    add_column :jobs, :seltrpos, :text
    add_column :jobs, :seltrecho, :text
    add_column :jobs, :seltrcomp, :text
    add_column :jobs, :seltredge, :text
    add_column :jobs, :seltrcalc, :text
    add_column :jobs, :catamenta, :text
  end
end
