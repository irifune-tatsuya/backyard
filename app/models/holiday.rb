class Holiday < ApplicationRecord
  validates :reason, presence: true

  belongs_to :user
  belongs_to :employee

  def add_or_delete
    if delete_day.present?
      "#{delete_day}日消化"
    else
      "#{add_day}日付与"
    end
  end
end
