class AddCardsColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :num_of_pick, :integer, default: 0, null: false
    add_column :cards, :num_of_use, :integer, default: 0, null: false
    add_column :cards, :num_of_win, :integer, default: 0, null: false
    add_column :cards, :sum_of_score, :integer, default: 0, null: false
    add_column :cards, :sum_of_pick, :integer, default: 0, null: false
    add_column :cards, :win_rate, :float, default: 0.0, null: false
    add_column :cards, :use_rate, :float, default: 0.0, null: false
    add_column :cards, :score_ave, :float, default: 0.0, null: false
    add_column :cards, :pick_ave, :float, default: 0.0, null: false

    add_column :picks, :used, :boolean, default: false, null: false
    add_column :cards, :category, :string
  end
end
