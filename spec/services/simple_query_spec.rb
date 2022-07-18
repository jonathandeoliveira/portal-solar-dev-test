require 'rails_helper'

describe '#simple_query service' do
  it 'Encontra objeto pelo nome' do

    power_generator1 = PowerGenerator.create!( name: 'GERADOR WEG', description: 'Um gerador laje', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13357/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546434535', 
      manufacturer: 'WEG', price: 49990.00, kwp: 17.34, height: 1.2, width: 0.2, lenght: 1.8,  weight: 118, structure_type: :metalico)
    power_generator2 = PowerGenerator.create!( name: 'GERADOR2', description: ' Um gerador metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/107646/large/Montagem_YC600.JPG?1566566821', 
      manufacturer: 'Solar Group', price: 2958.50, kwp: 0.68, height: 1.2, width: 0.3, lenght: 1.1, weight: 172, structure_type: :fibrocimento)
    power_generator3 = PowerGenerator.create!( name: 'GERADOR3', description: ' Um gerador trapezoidal', 
        image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13500/large/20190103-225-1sblgyr.?1546504464', 
        manufacturer: 'Q CELLS', price: 13000.35, kwp: 2.68, height: 0.6, width: 0.35, lenght: 1.9, weight: 150, structure_type: :trapezoidal)
    query = 'gerador weg'

    result = SimpleQuery.call(query)

    expect(result.count).to eq 1
    expect(result.first.name).to eq 'GERADOR WEG'
  end

  it 'Encontra objeto pela descrição' do

    power_generator1 = PowerGenerator.create!( name: 'GERADOR1', description: 'descrição bem extensa', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13357/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546434535', 
      manufacturer: 'WEG', price: 49990.00, kwp: 17.34, height: 1.2, width: 0.2, lenght: 1.8,  weight: 118, structure_type: :metalico)
    query = 'extensa'

    result = SimpleQuery.call(query)

    expect(result.count).to eq 1
    expect(result.first.name).to eq 'GERADOR1' 
    expect(result.first.description).to eq 'descrição bem extensa'
  end

  it 'Encontra objeto pelo fabricante' do

    power_generator1 = PowerGenerator.create!( name: 'GERADOR1', description: ' Um gerador metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13357/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546434535', 
      manufacturer: 'WEG', price: 49990.00, kwp: 17.34, height: 1.2, width: 0.2, lenght: 1.8,  weight: 118, structure_type: :metalico)
    power_generator2 = PowerGenerator.create!( name: 'GERADOR2 Testando', description: ' Um gerador também metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/107646/large/Montagem_YC600.JPG?1566566821', 
      manufacturer: 'Solar Group', price: 2958.50, kwp: 0.68, height: 1.2, width: 0.3, lenght: 1.1, weight: 172, structure_type: :fibrocimento)
    power_generator3 = PowerGenerator.create!( name: 'GERADOR3', description: ' Um gerador trapezoidal', 
        image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13500/large/20190103-225-1sblgyr.?1546504464', 
        manufacturer: 'fabricante', price: 13000.35, kwp: 2.68, height: 0.6, width: 0.35, lenght: 1.9, weight: 150, structure_type: :trapezoidal)
    query = 'fabricante'

    result = SimpleQuery.call(query)

    expect(result.count).to eq 1
    expect(result[0].manufacturer).to eq 'fabricante' 
  end

  it 'Encontra objeto por nome ou descrição ou fabricante' do
    power_generator1 = PowerGenerator.create!( name: 'match em nome', description: 'Um gerador metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13357/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546434535', 
      manufacturer: 'WEG', price: 49990.00, kwp: 17.34, height: 1.2, width: 0.2, lenght: 1.8,  weight: 118, structure_type: :metalico)
    power_generator2 = PowerGenerator.create!( name: 'GERADOR2', description: 'match em descrição', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/107646/large/Montagem_YC600.JPG?1566566821', 
      manufacturer: 'Solar Group', price: 2958.50, kwp: 0.68, height: 1.2, width: 0.3, lenght: 1.1, weight: 172, structure_type: :fibrocimento)
    power_generator3 = PowerGenerator.create!( name: 'GERADOR3', description: 'Um gerador trapezoidal', 
        image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13500/large/20190103-225-1sblgyr.?1546504464', 
        manufacturer: 'match em fabricante', price: 13000.35, kwp: 2.68, height: 0.6, width: 0.35, lenght: 1.9, weight: 150, structure_type: :trapezoidal)
    query = 'match'

    result = SimpleQuery.call(query)

    #de acordo com o filtro a busca sempre vai retornar do mais barato para o mais caro
    expect(result.count).to eq 3
    expect(result[0].name).to eq 'GERADOR2' 
    expect(result[0].description).to eq 'match em descrição' 
    expect(result[0].manufacturer).to eq 'Solar Group'
    expect(result[1].name).to eq 'GERADOR3' 
    expect(result[1].description).to eq 'Um gerador trapezoidal' 
    expect(result[1].manufacturer).to eq 'match em fabricante' 
    expect(result[2].name).to eq 'match em nome' 
    expect(result[2].description).to eq 'Um gerador metalico' 
    expect(result[2].manufacturer).to eq 'WEG' 
  end

  it 'e não encontra nenhum resultado' do
    power_generator_not_found = PowerGenerator.create!( name: 'GERADOR ABC', description: 'Um gerador metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/13357/large/Kit-Gerador-de-Energia-Solar-WEG---SIW500H---ST013-18-22.jpg?1546434535', 
      manufacturer: 'WEG', price: 49990.00, kwp: 17.34, height: 1.2, width: 0.2, lenght: 1.8,  weight: 118, structure_type: :metalico)
    query = 'KPYSZ'

    result = SimpleQuery.call(query)

    expect(result.count).to eq 0
  end


end