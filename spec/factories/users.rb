FactoryGirl.define do
  factory :user do
    provider 'twitter'
    sequence(:uid) { |i| "uid#{i}" }
    sequence(:nickname) { |i| "nickname#{i}" }
    sequence(:image_url) { |i| "http://example.com/image#{i}.jpg" }
  end

  trait :broken_peter do
    provider 'twitter'
    uid '2351441480'
    nickname 'broken_peter'
    image_url 'http://pbs.twimg.com/profile_images/714115257082515456/QakmXenG_normal.jpg'
  end
end
