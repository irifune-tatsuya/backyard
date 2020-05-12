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
    year = Date.today.year - hire_date.year
    
    if 0 < Date.today.month - hire_date.month
      month = Date.today.month - hire_date.month
    else
      month = Date.today.month - hire_date.month + 12
    end

    "#{year}年#{month}ヵ月"
  end
end
