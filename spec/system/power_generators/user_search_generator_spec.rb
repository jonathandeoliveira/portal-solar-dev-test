require 'rails_helper'

describe 'Usuário pesquisa um gerador' do
  it 'Pela busca Simples' do
    visit root_path

    expect(page).to have_button "Pesquisar"
  end
end