FactoryBot.define do
  factory :add_property, class: 'Property' do   
    placehouse {
      r = rand(0..1)
        if r == 0
          "Casa"
        else
          "Departamento"
        end
    }  
    title {Faker::Lorem.sentence}
    mts2 {Faker::Number.between(50,300) }
    street { Faker::Address.street_name }
    geolat {Faker::Address.latitude }
    geolng {Faker::Address.longitude }
    visits {Faker::Number.between(100,1000) }
    price {Faker::Number.decimal(6,2) }
    #urlimage {Faker::Avatar.image}   
    urlimage {
      images = [
        'https://cdn.pixabay.com/photo/2014/11/21/17/17/country-house-540796__340.jpg',
        'https://cdn.pixabay.com/photo/2013/10/09/02/27/boat-house-192990__340.jpg',
        'https://cdn.pixabay.com/photo/2016/06/24/10/47/architecture-1477041__340.jpg',
        'https://cdn.pixabay.com/photo/2017/09/09/18/25/living-room-2732939__340.jpg',
        'https://cdn.pixabay.com/photo/2017/07/02/16/33/church-2464899__340.jpg',
        'https://cdn.pixabay.com/photo/2017/03/22/17/39/kitchen-2165756__340.jpg',
        'https://cdn.pixabay.com/photo/2016/11/29/03/53/architecture-1867187__340.jpg',
        'https://cdn.pixabay.com/photo/2015/10/20/18/57/furniture-998265__340.jpg',
        'https://cdn.pixabay.com/photo/2017/11/16/19/29/spring-2955582__340.jpg',
        'https://cdn.pixabay.com/photo/2017/01/07/17/48/interior-1961070__340.jpg',
        'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174__340.jpg',
        'https://cdn.pixabay.com/photo/2017/06/13/22/42/kitchen-2400367__340.jpg',
        'https://cdn.pixabay.com/photo/2017/07/08/11/40/mau-2484144__340.jpg',
        'https://cdn.pixabay.com/photo/2017/07/08/11/46/tu-2484171__340.jpg',
        'https://cdn.pixabay.com/photo/2017/07/08/11/42/children-2484156__340.jpg',
        'https://cdn.pixabay.com/photo/2017/07/08/11/44/tu-2484161__340.jpg',
        'https://cdn.pixabay.com/photo/2017/07/08/11/39/tu-2484140__340.jpg',
        'https://cdn.pixabay.com/photo/2017/07/08/11/44/tu-2484160__340.jpg',
        'https://cdn.pixabay.com/photo/2017/07/08/11/36/tu-bep-2484132__340.jpg',
        'https://cdn.pixabay.com/photo/2017/12/27/14/42/furniture-3042835__340.jpg',
        'https://cdn.pixabay.com/photo/2018/11/06/05/57/apartment-3797468__340.jpg'
      ]
      randomImages = rand(0..19)
      images[randomImages]
    }   
    user # referencia a otro factory en este caso al factory user
  end
end












