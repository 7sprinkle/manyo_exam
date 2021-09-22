class Labeling < ApplicationRecord
  belongs_to :label
  belongs_to :task
  # validates :label_id, presence: true
  # validates :task_id, presence: true
end
