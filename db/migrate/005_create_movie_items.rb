class CreateMovieItems < ActiveRecord::Migration
  def self.up
    create_table :movie_items do |t|
      t.column  :movie_id,      :integer
      t.column  :user_id,       :integer
      t.column  :upc,           :integer
      t.column  :asin,          :string
      t.column  :available,     :boolean
    end
  end

  def self.down
    drop_table :movie_items
  end
end
