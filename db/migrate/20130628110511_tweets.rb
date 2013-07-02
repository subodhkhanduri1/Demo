class Tweets < ActiveRecord::Migration
  def up
    create_table :tweets do |t|
      t.column :user_id, :integer, :null => false
      t.column :message, :text, :limit => 200, :null => false
      t.column :created_at, :timestamp, :default => Time.now
    end
    #execute 'alter table tweets alter column created_at set default now()'
  end

  def down
    drop_table :tweets
  end
end