class Holiday < ApplicationRecord
  validates :reason, presence: true

  belongs_to :user
  belongs_to :employee
end
