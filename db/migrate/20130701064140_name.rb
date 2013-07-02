class Name < ActiveRecord::Migration
  def up
    execute("alter table users ")
  end

  def down
  end
end
