class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
     　
      t.timestamps
    end
  end
end
