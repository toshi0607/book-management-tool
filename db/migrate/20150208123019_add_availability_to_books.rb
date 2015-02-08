class AddAvailabilityToBooks < ActiveRecord::Migration
  def up
    add_column :books, :availability, :boolean
  end

  def down
    remove_column :books, :availability, :boolean
  end
end
