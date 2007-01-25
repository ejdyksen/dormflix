class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.column  :movie_item_id,         :integer
      t.column  :user_id,               :integer
      t.column  :checked_out,           :datetime
      t.column  :due_date,              :datetime
      t.column  :complete,              :boolean
    end
  end

  def self.down
    drop_table :requests
  end
end
