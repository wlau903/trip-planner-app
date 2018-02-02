class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.date :date
      t.string :destination
      t.text :activities
      t.integer :user_id
    end
  end

end
