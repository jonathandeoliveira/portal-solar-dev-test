require 'rails_helper'

RSpec.describe PowerGenerator, type: :model do
  describe '#valid?' do
    subject do
      power_generator = PowerGenerator.create!( name: 'TRIFÁSICO 380V', description: ' Um gerador bem bacana', 
            image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13357/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546434535', 
            manufacturer: 'WEG', price: 49990.00, kwp: 17.34, height: 1.2, width: 0.2, lenght: 1.8,  weight: 118, structure_type: :metalico)
    end
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:kwp) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:manufacturer) }
    it { should validate_presence_of(:image_url) }
    it {should validate_numericality_of(:height).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:height).is_less_than_or_equal_to(40)}
    it {should validate_numericality_of(:width).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:width).is_less_than_or_equal_to(100)}
    it {should validate_numericality_of(:lenght).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:lenght).is_less_than_or_equal_to(200)}
    it {should validate_numericality_of(:weight).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:weight).is_less_than_or_equal_to(3000)}
    it { should define_enum_for(:structure_type) }
  end

  describe '#cubic_weight_calculator' do
    it 'calcula o peso cubado com sucesso' do
      power_generator = PowerGenerator.create!( name: 'TRIFÁSICO 380V', description: ' Um gerador bem bacana', 
        image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13357/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546434535', 
        manufacturer: 'WEG', price: 49990.00, kwp: 17.34, height: 1.2, width: 0.2, lenght: 1.8, weight: 118, structure_type: :metalico)

      power_generator.cubic_weight_calculator
      result = power_generator.cubic_weight

      expect(result).not_to be nil
      expect(result.class).to eq Float
    end
  end



end
