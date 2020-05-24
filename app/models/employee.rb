class Employee < ApplicationRecord
  validates :name, presence: true
  validates :hire_date, presence: true

  belongs_to :branch
  has_many :holidays, dependent: :destroy

  def grant_date
    hire_date >> 6
  end

  def year_of_service
    if Date.today.month - hire_date.month >= 0
      year = Date.today.year - hire_date.year
      month = Date.today.month - hire_date.month
    else
      year = Date.today.year - hire_date.year - 1
      month = Date.today.month - hire_date.month + 12
    end
    "#{year}年#{month}ヵ月"
  end

  def range_to_delete
    month = grant_date.month
    day = grant_date.mday
    year = Date.today.year
    last_grant_date = Time.local(year, month, day)

    if last_grant_date > Date.today
      last_year = year - 1
      last_grant_date = Time.local(last_year, month, day)
    end
    holidays.where(registration_date: last_grant_date..Date.tomorrow)
  end

  def range_to_add
    month = grant_date.month
    day = grant_date.mday
    year = Date.today.year
    last_grant_date = Time.local(year, month, day)

    if last_grant_date <= Date.today
      last_year = year - 1
      last_grant_date = Time.local(last_year, month, day)
    else
      two_years_ago = year - 2
      last_grant_date = Time.local(two_years_ago, month, day)
    end
    holidays.where(registration_date: last_grant_date..Date.tomorrow)
  end

  def total_delete_day
    range_to_delete.sum(:delete_day)
  end

  def total_add_day
    range_to_add.sum(:add_day)
  end

  def calculate_remaining_days
    a = total_delete_day
    b = total_add_day
    b - a
  end

  def delete_days_alert
    a = total_delete_day
    b = total_add_day

    if b >= 10 && a < 5
      "未消化"
    else
      "-"
    end
  end
end
