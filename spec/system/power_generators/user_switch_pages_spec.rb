require 'rails_helper'

describe 'Usuário visita as páginas de produtos' do
  it 'a primeira página, com sucesso' do
    
    visit root_path

    expect(page).to have_content 'Geradores de Energia'
    expect(page).not_to have_link 'Anterior'
    expect(page).not_to have_link 'Primeiro'
    expect(page).to have_link 'Próximo'
    expect(page).to have_link 'Último'
  end

  it 'alguma página entre a primeira e a última, com sucesso' do
    
    visit root_path
    within('section#margem-topo') do
      click_on 'Próximo'
    end

    expect(page).to have_content 'Geradores de Energia'
    expect(page).to have_link 'Anterior'
    expect(page).to have_link 'Primeiro'
    expect(page).to have_link 'Próximo'
    expect(page).to have_link 'Último'
  end

  it 'a última página, com sucesso' do
    
    visit root_path
    within('section#margem-topo') do
      click_on 'Último'
    end

    expect(page).to have_content 'Geradores de Energia'
    expect(page).to have_link 'Anterior'
    expect(page).to have_link 'Primeiro'
    expect(page).not_to have_link 'Próximo'
    expect(page).not_to have_link 'Último'
  end

end