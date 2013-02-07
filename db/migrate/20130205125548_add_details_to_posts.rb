class AddDetailsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :city, :string

    add_column :posts, :state, :string

    add_column :posts, :latitude, :float

    add_column :posts, :longitude, :float

  end
end
