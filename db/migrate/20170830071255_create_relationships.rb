class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :followed_id
      t.integer :following_id

      t.timestamps
      add_index  :relationships, [:following_id, :followed_id], unique: true
    end
  end
end
