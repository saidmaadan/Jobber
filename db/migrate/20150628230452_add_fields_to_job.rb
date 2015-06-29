class AddFieldsToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :country, :string
    add_column :jobs, :state, :string
    add_column :jobs, :city, :string
  end
end
