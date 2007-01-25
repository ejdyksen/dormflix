class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column  :email,             :string
      t.column  :hashed_password,   :string
      t.column  :salt,              :string
      t.column  :verification_key,  :string
      t.column  :first_name,        :string
      t.column  :last_name,         :string
      t.column  :dorm,              :string
      t.column  :im_addr,           :string
      t.column  :about,             :text
    end
  end

  def self.down
    drop_table :users
  end
end
