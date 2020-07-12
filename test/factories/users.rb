FactoryBot.define do
  factory :user do
    email { Faker::Internet.email } #=> "Christophe Bartell"
    name { Faker::Name.name  } #=> "kirsten.greenholt@corkeryfisher.info"
    auth_token { "MyTokenString" }
  end
end