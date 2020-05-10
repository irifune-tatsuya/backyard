class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name,               null: false
      t.integer :employment_status, null: false
      t.date :hire_date,            null: false
      t.references :branch,         foreign_key: true
      t.timestamps
    end
    add_index :employees, :name
    add_index :employees, :hire_date
  end
end
