FactoryBot.define do
  factory :user do
    username { "Atte" }
    password { "Salasana123"}
    password_confirmation { "Salasana123"}
  end

  factory :brewery do
    name { "viikkibrew" }
    year 2018
  end

  factory :style do
    name { "lager" }
    description { "namimaiskis" }
  end

  factory :beer do
    name { "lato" }
    style
    brewery
  end

  factory :rating do
    score { 10 }
    beer
    user
  end
end
