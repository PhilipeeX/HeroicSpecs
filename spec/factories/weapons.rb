FactoryBot.define do
  factory :weapon do
    name { ["Excalibur", "Brisingr", "Sting", "Andúril", "Ice", "Longclaw", "Oathkeeper", "Glamdring", "Masamune", "Muramasa"].sample }
    description { FFaker::Lorem.sentence }
    power_base { rand(3000..4000) }
    power_step { rand(50..150) }
    level { rand(1..99) }
  end
end
