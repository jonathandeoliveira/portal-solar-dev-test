require 'rails_helper'

describe 'Usuário vê detalhes de um gerador' do
  it 'a partir da página inicial, com sucesso' do

    visit root_path
    click_on 'POLI HALF CELL'

    expect(page).to have_content 'Detalhes sobre o produto:POLI HALF CELL'
    expect(page).to have_content 'Tipo de estrutura: metalico'
    expect(page).to have_content 'Dimensões: 1.0m x 0.35m x 2.0m'
    expect(page).to have_content 'Quilowatt Pico: 2.68kWp'
    expect(page).to have_content 'Peso: 110.0 Kg'
    expect(page).to have_content 'Peso Cubado: 210.0 Kg'
    expect(page).to have_content 'Consultar Frete:'
    expect(page).to have_link 'Voltar'
    expect(page).to have_field 'CEP'
    expect(page).to have_button 'Calcular'
  end
end