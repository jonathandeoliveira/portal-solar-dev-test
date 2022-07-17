require 'rails_helper'

describe 'Usuário pesquisa um gerador' do
  it 'pela busca simples' do
    visit root_path
    choose('simpleSearch').click

    expect(page).to have_field 'o que procura?'
    expect(page).to have_button "Pesquisar"
    expect(page).not_to have_field 'Nome'
    expect(page).not_to have_field 'Fabricante'
  end

  it 'Pela busca simples, com sucesso' do
    visit root_path
    fill_in 'o que procura?', with: 'híbrido'
    click_on 'Pesquisar'

    expect(page).to have_content 'Resultados da Pesquisa:'
    expect(page).to have_content 'WEG HÍBRIDO'
    expect(page).to have_content 'R$ 12.582,30'
    expect(page).to have_link "Voltar"
  end

  xit 'pela busca avançada' do
    visit root_path
    within('div#advanced-search') do
      choose('advancedSearch').click
    end
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Fabricante'
    expect(page).to have_button 'Pesquisa Avançada'
  end
end