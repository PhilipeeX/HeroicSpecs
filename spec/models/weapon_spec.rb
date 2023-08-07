require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it 'is invalid if the level is not between 1 and 99' do
    weapon = build(:weapon, level: FFaker::Random.rand(100..9999))

    expect(weapon).to_not be_valid
  end

  it 'should have correct current_power' do
    weapon = build(:weapon, power_base: 4000, level: 5, power_step: 50)

    expect(weapon.current_power).to eq(4200)
  end

  it 'should have correct title' do
    weapon_name = "Excalibur"
    weapon_level = 12
    weapon = build(:weapon, level: 12, name: "Excalibur")

    expect(weapon.title).to eq("#{weapon_name} ##{weapon_level}")
  end
end
