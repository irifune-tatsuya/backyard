class CreateHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :holidays do |t|
      t.date :registration_date, null: false
      t.integer :add_day
      t.integer :delete_day
      t.string :reason,          null: false, default: "法定付与日のため"
      t.references :user,        foreign_key: true
      t.references :employee,    foreign_key: true
      t.timestamps
    end
    add_index :holidays, :add_day
    add_index :holidays, :delete_day
  end
end