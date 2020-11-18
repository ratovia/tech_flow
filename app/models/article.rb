class Article < ApplicationRecord
  has_many :issues, dependent: :destroy
end
