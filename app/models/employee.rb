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
    if Date.today.month - hire_date.month >= 0
      year = Date.today.year - hire_date.year
      month = Date.today.month - hire_date.month
    else
      year = Date.today.year - hire_date.year - 1
      month = Date.today.month - hire_date.month + 12
    end
    "#{year}年#{month}ヵ月"
  end

  def total_delete_day
    grant_day = hire_date >> 6
    month = grant_day.month
    day = grant_day.mday
    year = Date.today.year
    grant_date_this_year = Time.local(year, month, day)

    if grant_date_this_year > Date.today
      last_year = year - 1
      grant_date_this_year = Time.local(last_year, month, day)
    else
      grant_date_this_year
    end
    range_to_delete = holidays.where(created_at: grant_date_this_year..Date.today)
    range_to_delete.sum(:delete_day)
  end

  def last_add_day
    if holidays.where.not(add_day: nil).present?
      all_add_day = holidays.where.not(add_day: nil).pluck(:add_day)
      all_add_day.last
    else
      0
    end
  end

  def calculate_remaining_days
    a = total_delete_day
    b = last_add_day
    b - a
  end
end
