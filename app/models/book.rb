class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :availability, inclusion: { in: [true, false] }
end
