class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings
  # has_many :labeling_tasks, through: :labelings, source: :task
  validates :name, uniqueness: true, presence: true
end
