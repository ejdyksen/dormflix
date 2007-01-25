class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.column  :upc,                     :string, :limit => 32
      t.column  :asin,                    :string, :limit => 32
      t.column  :title,                   :string
      t.column  :directors,               :string
      t.column  :mpaa_rating,             :string
      t.column  :theatrical_release_date, :date
      t.column  :image_url_small,         :string
      t.column  :image_url_medium,        :string
      t.column  :image_url_large,         :string
      t.column  :description,             :text
      t.column  :actors,                  :text
    end
  end

  def self.down
    drop_table :movies
  end
end
