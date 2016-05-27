class Event < ActiveRecord::Base
  validates :name, length: { maximum: 50 }, presence: true
  validates :place, presence: true
  validates :content, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
