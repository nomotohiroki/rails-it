class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.string :email
      t.string :library_path
      t.boolean :complete
      t.timestamp :created_on

      t.timestamps
    end
  end
end
