class PropertySerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :placehouse, :visits, :price, :urlimage, :address, :autor

  attribute :address do |object|
    { 
      street: object.street,
      geo: { 
        lat: object.geolat,
        lng: object.geolng
      }
    }        
  end

  attribute :autor do |object|
    { 
      name: object.user.name,
      email: object.user.email,
      id: object.user.id
    }        
  end

end
