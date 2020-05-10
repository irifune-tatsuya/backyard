class Employee < ApplicationRecord
  validates :name, presence: true
  validates :hire_date, presence: true

  belongs_to :branch
  has_many :holidays
end
