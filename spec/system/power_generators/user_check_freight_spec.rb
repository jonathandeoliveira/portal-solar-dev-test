require 'rails_helper'

describe 'Usuário consulta frete' do
  it 'a partir dos detalhes de um gerador' do 
    power_generator = PowerGenerator.create!( name: 'GERADOR ABC', description: ' Um gerador metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/107646/large/Montagem_YC600.JPG?1566566821', 
      manufacturer: 'Solar Group', price: 2958.50, kwp: 0.68, height: 1.2, width: 0.3, lenght: 1.1, weight: 172, cubic_weight:138.6, structure_type: :fibrocimento)

    visit power_generator_path(power_generator)

    expect(page).to have_content 'Detalhes sobre o produto:GERADOR ABC'
    expect(page).to have_content 'R$ 2.958,50'
    expect(page).to have_content 'Tipo de estrutura: fibrocimento'
    expect(page).to have_content 'Quilowatt Pico: 0.68kWp'
    expect(page).to have_content 'Dimensões: 1.2m x 0.3m x 1.1m'
    expect(page).to have_content 'Peso: 172.0 Kg'
    expect(page).to have_content 'Peso Cubado: 138.6 Kg'
    expect(page).to have_content 'Descrição: Um gerador metalico'
    expect(page).to have_content 'Consultar Frete:'
    expect(page).to have_link 'Voltar'
    expect(page).to have_field 'CEP'
    expect(page).to have_button 'Calcular'
  end

  it 'com sucesso' do
    power_generator = PowerGenerator.create!( name: 'GERADOR ABC', description: ' Um gerador metalico', 
      image_url: 'https://marketplace-img-production.s3.amazonaws.com/products/107646/large/Montagem_YC600.JPG?1566566821', 
      manufacturer: 'Solar Group', price: 2958.50, kwp: 0.68, height: 1.2, width: 0.3, lenght: 1.1, weight: 172, cubic_weight:138.6, structure_type: :fibrocimento)
    cep = '17560057'

    visit power_generator_path(power_generator)
    fill_in 'CEP', with: "#{cep}"
    click_on 'Calcular'

    expect(current_path).to eq check_freight_power_generators_path
    expect(page).to have_content 'Frete Total:R$ 388,90'
    expect(page).to have_content 'Consultar novo frete:'
    expect(page).to have_field 'CEP'
    expect(page).to have_button 'Calcular'
  end
end