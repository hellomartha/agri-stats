class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :user_name
      t.string :image_url
    end
    add_reference :results, :user, index: true
  end
end
