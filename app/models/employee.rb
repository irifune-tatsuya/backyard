class Employee < ApplicationRecord
  validates :name, presence: true
  validates :hire_date, presence: true

  belongs_to :branch
  has_many :holidays

  def calculate_grant_date
    grant_day = hire_date >> 6
    grant_day.strftime("%m/%d")
  end

  def calculate_year_of_service
    if Date.today.month - hire_date.month > 0
      year = Date.today.year - hire_date.year
      month = Date.today.month - hire_date.month
    else
      year = Date.today.year - hire_date.year - 1
      month = Date.today.month - hire_date.month + 12
    end
    "#{year}年#{month}ヵ月"
  end

  def total_delete_day
    sum = holidays.sum(:delete_day)
  end

end
