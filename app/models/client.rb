class Client < ApplicationRecord
  has_many :memberships
  has_many :gyms, through: :memberships

  validates :name, presence: true

  # def total_amount
  #   total_amount_from_memberships = 0
  #   self.memberships.each do |membership|
  #     total_amount_from_memberships += membership.charge
  #   end
  #   total_amount_from_memberships
  # end
end
