class AddElementToSite < ActiveRecord::Migration[5.1]
  def change
    add_column :sites, :element, :string
  end
end
