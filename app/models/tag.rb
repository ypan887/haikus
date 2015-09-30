class Tag < ActiveRecord::Base
  validates :haiku_id, presence: true
  validates :tag, presence: true
end
