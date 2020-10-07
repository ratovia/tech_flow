class Issue < ApplicationRecord
  has_ancestry
  belongs_to :article
end
