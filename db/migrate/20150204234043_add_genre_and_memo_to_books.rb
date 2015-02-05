class AddGenreAndMemoToBooks < ActiveRecord::Migration
  def up
    add_column :books, :genre, :string
    add_column :books, :memo, :string
  end

  def down
    remove_column :books, :genre, :string
    remove_column :books, :memo, :string
  end
end
