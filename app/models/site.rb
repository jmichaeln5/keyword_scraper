class Site < ApplicationRecord
  belongs_to :user
  validates :link, :presence => true
end


# https://guides.rubyonrails.org/v3.2.13/active_record_validations_callbacks.html#presence
