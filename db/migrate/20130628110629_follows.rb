class Follows < ActiveRecord::Migration
  def up
    create_table :follows do |t|
      t.column :follower_id, :integer, :null => false
      t.column :following_id, :integer, :null => false
      t.column :created_at, :timestamp, :default => Time.now
    end
  end

  def down
    drop_table :follows
  end
end
