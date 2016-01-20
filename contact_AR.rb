class Contact < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { minimum: 3 }
end