class CreateIndicesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :indices_users, :id => false do |t|
      t.integer :index_id
      t.integer :user_id
    end
  end
end
