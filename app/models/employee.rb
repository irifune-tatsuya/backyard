class Employee < ApplicationRecord
  validates :name, presence: true
  validates :hire_date, presence: true

  belongs_to :branch
  has_many :holidays

  def calculate_grant_day
    grant_day = hire_date >> 6
    grant_day.strftime("%m/%d")
  end
end
