class CreateDb < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :name_en  
      t.string :name_ja  
      t.string :number
    end

    create_table :results do |t|
      t.integer :player
      t.integer :turn_number
      t.integer :rank
      t.integer :score
    end

    create_table :picks do |t|
      t.integer :pick_number
      t.references :card, foreign_key: true
      t.references :result, foreign_key: true
    end
  end
end
