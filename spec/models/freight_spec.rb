require 'rails_helper'

RSpec.describe PowerGenerator, type: :model do
  describe '#valid?' do
    subject do
      freight = Freight.create!(state: 'AC', weight_min: 71, weight_max:80, cost:57.04)
    end
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:weight_min) }
    it { should validate_presence_of(:weight_max) }
    it { should validate_presence_of(:cost) }
  end
end
