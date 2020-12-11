class AddColumnCalcTarget < ActiveRecord::Migration[6.0]
  def change
    add_column :results, :calc_target, :boolean, default: true, null: false
  end
end
