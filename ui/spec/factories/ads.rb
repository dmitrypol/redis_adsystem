FactoryGirl.define do
  factory :ad do
    keywords    'keyword1,keyword2'
    cpc         1
    budget      10
    title       'title 1'
    body        'body 1'
    link        'http://website1.com'
  end
end
