class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :name, :auth_token

end
