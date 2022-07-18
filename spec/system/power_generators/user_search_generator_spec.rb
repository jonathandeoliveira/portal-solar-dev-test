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

  it 'Pela busca simples, com campo em branco' do
    visit root_path
    fill_in 'o que procura?', with: ''
    click_on 'Pesquisar'

    expect(page).to have_content 'Campo de pesquisa em branco'
  end

  it 'Pela busca simples, e não encontra nenhum resultado' do
    visit root_path
    fill_in 'o que procura?', with: 'AXSRRFSAEA'
    click_on 'Pesquisar'

    expect(page).to have_content 'Resultados da Pesquisa:'
    expect(page).to have_content 'Não foi encotrado nenhum gerador com os parametros inseridos.'
  end

end