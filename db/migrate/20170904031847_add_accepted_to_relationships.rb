class AddAcceptedToRelationships < ActiveRecord::Migration[5.1]
  def change
    add_column :relationships, :accepted, :boolean, default: true
  end
end
