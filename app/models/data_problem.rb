class DataProblem < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :person, optional: true
end
