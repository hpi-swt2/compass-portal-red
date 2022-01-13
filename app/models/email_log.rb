class EmailLog < ApplicationRecord
  belongs_to :person, optional: true
end
