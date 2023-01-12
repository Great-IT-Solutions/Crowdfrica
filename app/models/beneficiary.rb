class Beneficiary < ApplicationRecord
  enum btype: { patient: 0, health_facility: 1, classroom_supplies: 2, entrepreneur: 3 }

  has_many :projects
end
