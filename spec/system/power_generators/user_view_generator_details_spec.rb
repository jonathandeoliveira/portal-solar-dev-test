require 'rails_helper'

describe 'Usuário vê detalhes de um gerador' do
  it 'com sucesso' do
    visit root_path
    click_on 'WEG HÍBRIDO'

    expect(page).to have_content 'Detalhes sobre o produto: WEG HÍBRIDO'
    expect(page).to have_content 'Tipo de estrutura:'
    expect(page).to have_content 'Dimensões:'
    expect(page).to have_content 'Quilowatt Pico:'
    expect(page).to have_content 'Peso Cubado:'
  end
end