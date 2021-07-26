class AddColumnNote < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :note, :string
  end
end
