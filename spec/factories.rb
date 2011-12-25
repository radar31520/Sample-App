FactoryGirl.define do
  # This will setup the factor user class
  factory :user do
  name                    "Duane Carver"
  email                   "dcarver3@example.com"
  password                "foobar"
  password_confirmation   "foobar"
  end

end

