require 'rails_helper'

describe '#advanced_query service' do
  it 'Encontra objeto pela combinação de parâmetros' do

    power_generator1 = PowerGenerator.create!( name: 'GERADOR ABC', description: ' Um gerador metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/107646/large/Montagem_YC600.JPG?1566566821', 
      manufacturer: 'Solar Group', price: 2958.50, kwp: 0.68, height: 1.2, width: 0.3, lenght: 1.1, weight: 172, structure_type: :fibrocimento)
    power_generator2 = PowerGenerator.create!( name: 'GERADOR XTREME 123', description: ' Um gerador trapezoidal', 
        image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13500/large/20190103-225-1sblgyr.?1546504464', 
        manufacturer: 'WEG', price: 13000.35, kwp: 2.68, height: 0.6, width: 0.35, lenght: 1.9, weight: 150, structure_type: :laje)
    power_generator3 = PowerGenerator.create!( name: 'GERADOR XYZ', description: 'Um gerador tipo laje', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13357/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546434535', 
      manufacturer: 'WEG', price: 49990.00, kwp: 17.34, height: 1.2, width: 0.2, lenght: 1.8,  weight: 118, structure_type: :laje)
    query ={name:'x', manufacturer:'WEG', structure_type:'3'}

    result = AdvancedQuery.call(query)

    expect(result.count).to eq 2
    expect(result[0].name).to eq 'GERADOR XTREME 123'
    expect(result[1].name).to eq 'GERADOR XYZ'
  end

  it 'E não encontra objeto pela combinação de parâmetros' do

    power_generator1 = PowerGenerator.create!( name: 'GERADOR ABC', description: ' Um gerador metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/107646/large/Montagem_YC600.JPG?1566566821', 
      manufacturer: 'Solar Group', price: 2958.50, kwp: 0.68, height: 1.2, width: 0.3, lenght: 1.1, weight: 172, structure_type: :fibrocimento)
    query ={name:'x', manufacturer:'WEG', structure_type:'3'}

    result = AdvancedQuery.call(query)

    expect(result.count).to eq 0
  end


end