class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.integer :point
      t.integer :friends_a
      t.integer :friends_b
      t.integer :weak_team
      t.integer :num_of_fof
      t.integer :friends_weak
      t.integer :fof
      t.integer :ct_people
      t.integer :ct_amount

      t.timestamps
    end
  end
end
