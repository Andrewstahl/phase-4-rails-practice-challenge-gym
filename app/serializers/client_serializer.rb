class ClientSerializer < ActiveModel::Serializer  
  attributes :id, :name, :age, :total_charges_from_memberships
  
  def total_charges_from_memberships
    total_charges_from_memberships = 0
    object.memberships.each do |membership|
      total_charges_from_memberships += membership.charge
    end
    total_charges_from_memberships
  end

end
