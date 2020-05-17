class Holiday < ApplicationRecord
  validates :reason, presence: true
  validates :add_day, exclusion: { in: [0]}
  validates :delete_day, exclusion: { in: [0]}

  belongs_to :user
  belongs_to :employee

  def add_or_delete
    if add_day.nil?
      "#{delete_day}日消化"
    elsif delete_day.nil?
      "#{add_day}日付与"
    else
      "#{add_day}日付与と#{delete_day}日消化"
    end
  end
end